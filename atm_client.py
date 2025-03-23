import tkinter as tk
import socket
import json
from tkinter import messagebox

class ATMClient:
    def __init__(self, master):
        self.master = master
        self.master.title("ATM客户端")
        screen_width = self.master.winfo_screenwidth()
        screen_height = self.master.winfo_screenheight()
        width = 300
        height = 250  
        x = (screen_width - width) // 2
        y = (screen_height - height) // 2
        self.master.geometry(f"{width}x{height}+{x}+{y}")

        self.user_id = tk.StringVar()
        self.password = tk.StringVar()
        self.balance = tk.StringVar()
        self.amount = tk.StringVar()
        self.server_ip = tk.StringVar()  

        self.create_widgets()
        self.socket = None

    def create_widgets(self):
        # 登录界面
        self.login_frame = tk.Frame(self.master)
        self.login_frame.pack(expand=True)  

        tk.Label(self.login_frame, text="服务器 IP:").grid(row=0, column=0, padx=5, pady=5)
        tk.Entry(self.login_frame, textvariable=self.server_ip).grid(row=0, column=1, padx=5, pady=5)
        tk.Label(self.login_frame, text="账号:").grid(row=1, column=0, padx=5, pady=5)
        tk.Entry(self.login_frame, textvariable=self.user_id).grid(row=1, column=1, padx=5, pady=5)
        tk.Label(self.login_frame, text="密码:").grid(row=2, column=0, padx=5, pady=5)
        tk.Entry(self.login_frame, textvariable=self.password, show="*").grid(row=2, column=1, padx=5, pady=5)
        tk.Button(self.login_frame, text="登录", command=self.login).grid(row=3, columnspan=2, padx=5, pady=20)

        # 操作界面
        self.operation_frame = tk.Frame(self.master)
        self.operation_frame.pack(expand=True)  

        tk.Label(self.operation_frame, text="余额:").grid(row=0, column=0, padx=5, pady=5)
        tk.Label(self.operation_frame, textvariable=self.balance).grid(row=0, column=1, padx=5, pady=5)
        tk.Label(self.operation_frame, text="取款金额:").grid(row=1, column=0, padx=5, pady=5)
        tk.Entry(self.operation_frame, textvariable=self.amount).grid(row=1, column=1, padx=5, pady=5)
        tk.Button(self.operation_frame, text="查询余额", command=lambda: self.query_balance(True)).grid(row=2, column=0, padx=5, pady=20)
        tk.Button(self.operation_frame, text="确认取款", command=self.withdraw).grid(row=2, column=1, padx=5, pady=20)
        tk.Button(self.operation_frame, text="再见", command=self.bye).grid(row=3, column=0, padx=5, pady=20)

        self.operation_frame.pack_forget()

    def bye(self):
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(5) 
            self.socket.connect((self.server_ip.get(), 2525)) 

            self.socket.sendall(f"HELO {self.user_id.get()}\n".encode())
            self.socket.recv(1024)

            self.socket.sendall(f"PASS {self.password.get()}\n".encode())
            self.socket.recv(1024)

            self.socket.sendall("BYE\n".encode())
            response = self.socket.recv(1024).decode().strip()

            if response == "BYE":
                messagebox.showinfo("提示", "欢迎下一次使用ATM机")
                self.user_id.set("")
                self.password.set("")
                self.server_ip.set("")
                self.operation_frame.pack_forget()
                self.login_frame.pack()
            else:
                messagebox.showerror("错误", "退出失败，请稍后重试")
        except socket.timeout:
            messagebox.showerror("错误", "连接超时，请检查网络或服务器状态")
        except Exception as e:
            messagebox.showerror("错误", str(e))
        finally:
            if self.socket:
                self.socket.close()

    def login(self):
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(5) 
            self.socket.connect((self.server_ip.get(), 2525))

            # 发送 HELO 消息
            self.socket.sendall(f"HELO {self.user_id.get()}\n".encode())
            response = self.socket.recv(1024).decode().strip()

            if response.startswith("500"):
                # 发送 PASS 消息
                self.socket.sendall(f"PASS {self.password.get()}\n".encode())
                response = self.socket.recv(1024).decode().strip()

                if response.startswith("525"):
                    self.login_frame.pack_forget()
                    self.operation_frame.pack()
                    self.query_balance(False)
                else:
                    messagebox.showerror("错误", "登录失败，请检查账号或密码")
            else:
                messagebox.showerror("错误", "无效用户，请检查账号")
        except Exception as e:
            messagebox.showerror("错误", str(e))
        finally:
            if self.socket:
                self.socket.close()

    def query_balance(self, show_popup=True):
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(5) 
            self.socket.connect((self.server_ip.get(), 2525))  

            self.socket.sendall(f"HELO {self.user_id.get()}\n".encode())
            self.socket.recv(1024)

            self.socket.sendall(f"PASS {self.password.get()}\n".encode())
            self.socket.recv(1024)

            self.socket.sendall("BALA\n".encode())
            response = self.socket.recv(1024).decode().strip()

            if response.startswith("AMNT"):
                balance = response.split(":")[1]
                self.balance.set(balance)
                if show_popup:
                    # 弹窗显示余额
                    messagebox.showinfo("余额查询结果", f"您的当前余额为: {balance}")
            else:
                messagebox.showerror("错误", "余额查询失败，请稍后重试")
        except socket.timeout:
            messagebox.showerror("错误", "连接超时，请检查网络或服务器状态")
        except Exception as e:
            messagebox.showerror("错误", str(e))
        finally:
            if self.socket:
                self.socket.close()

    def withdraw(self):
        try:
            self.socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            self.socket.settimeout(5) 
            self.socket.connect((self.server_ip.get(), 2525))

            self.socket.sendall(f"HELO {self.user_id.get()}\n".encode())
            self.socket.recv(1024)

            self.socket.sendall(f"PASS {self.password.get()}\n".encode())
            self.socket.recv(1024)

            self.socket.sendall(f"WDRA {self.amount.get()}\n".encode())
            response = self.socket.recv(1024).decode().strip()

            if response.startswith("525"):
                messagebox.showinfo("成功", "取款成功")
                self.query_balance()
            else:
                messagebox.showerror("错误", "取款失败，请检查余额或输入金额")
        except socket.timeout:
            messagebox.showerror("错误", "连接超时，请检查网络或服务器状态")
        except Exception as e:
            messagebox.showerror("错误", str(e))
        finally:
            if self.socket:
                self.socket.close()


if __name__ == "__main__":
    root = tk.Tk()
    app = ATMClient(root)
    root.mainloop()