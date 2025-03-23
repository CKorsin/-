import socket
import threading
import json
import logging
from datetime import datetime

logging.basicConfig(filename='server.log', level=logging.INFO,
                    format='%(asctime)s - %(levelname)s - %(message)s',encoding='utf-8')

class ATMServer:
    def __init__(self, port=2525):
        self.port = port
        self.users = self.load_users()
        self.server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server_socket.bind(('10.245.19.34', self.port))
        self.server_socket.listen(5)
        logging.info(f"服务器启动，监听端口 {self.port}")

    def load_users(self):
        try:
            with open('users.json', 'r') as f:
                return json.load(f)
        except FileNotFoundError:
            return {}

    def save_users(self):
        with open('users.json', 'w') as f:
            json.dump(self.users, f, indent=4)

    def handle_client(self, client_socket, addr):
        logging.info(f"新连接: {addr}")
        try:
            user_id = None
            while True:
                data = client_socket.recv(1024).decode().strip()
                if not data:
                    break
                
                if data.startswith("HELO"):
                    user_id = data.split()[1]
                    if user_id not in self.users:
                        client_socket.sendall("500 AUTH REQUIRE\n".encode())
                    else:
                        client_socket.sendall("500 AUTH REQUIRE\n".encode())
                    
                elif data.startswith("PASS"):
                    password = data.split()[1]
                    if user_id in self.users and self.users[user_id]['password'] == password:
                        client_socket.sendall("525 OK!\n".encode())
                    else:
                        client_socket.sendall("401 ERROR!\n".encode())
                    
                elif data == "BALA":
                    balance = self.users[user_id]['balance']
                    client_socket.sendall(f"AMNT:{balance}\n".encode())
                    logging.info(f"{user_id} 查询余额: {balance}")
                    
                elif data.startswith("WDRA"):
                    amount = int(data.split()[1])
                    if self.users[user_id]['balance'] >= amount:
                        self.users[user_id]['balance'] -= amount
                        self.save_users()
                        client_socket.sendall("525 OK\n".encode())
                        logging.info(f"{user_id} 取款: {amount}，余额: {self.users[user_id]['balance']}")
                    else:
                        client_socket.sendall("401 ERROR!\n".encode())
                        logging.warning(f"{user_id} 取款失败: 余额不足")
                    
                elif data == "BYE":
                    client_socket.sendall("BYE\n".encode())
                    logging.info(f"{user_id} 退出系统")
                    break
        except Exception as e:
            logging.error(f"客户端处理错误: {str(e)}")
        finally:
            client_socket.close()
            logging.info(f"连接关闭: {addr}")

    def run(self):
        while True:
            client_socket, addr = self.server_socket.accept()
            threading.Thread(target=self.handle_client, args=(client_socket, addr)).start()

if __name__ == "__main__":
    server = ATMServer()
    server.run()