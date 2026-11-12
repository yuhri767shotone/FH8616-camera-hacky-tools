#!/usr/bin/env python3
C=Exception
import socket as A,threading as H,queue as I,time,tkinter as B
from tkinter import simpledialog as K,messagebox as L
import cv2 as D
from PIL import Image,ImageTk as O
M='admin'
N='admin123456'
P=8554
Q='profile0'
E=1300
R='/app/bin/cmd'
F=100
G=500
def S(ip,command,timeout=3):
	D=timeout;F=f"<SYSTEM>{R} {command}</SYSTEM>".encode()
	try:
		with A.create_connection((ip,E),timeout=D)as B:
			B.sendall(F);B.settimeout(D)
			try:return B.recv(1024).decode(errors='replace')
			except A.timeout:return''
	except C as G:return f"ERROR: {G}"
def J(ip,shell_cmd,timeout=3):
	D=timeout;H=f"<SYSTEM>{shell_cmd}</SYSTEM>".encode()
	try:
		with A.create_connection((ip,E),timeout=D)as B:
			B.sendall(H);B.settimeout(D);F=[]
			try:
				while True:
					G=B.recv(4096)
					if not G:break
					F.append(G)
			except A.timeout:pass
			return b''.join(F).decode(errors='replace')
	except C as I:return f"ERROR: {I}"
class T:
	def __init__(A,root,ip):
		J=root;A.root=J;A.ip=ip;A.root.title(f"Camera Control — {ip}");A.root.configure(bg='black');A.frame_q=I.Queue(maxsize=2);A.running=True;A.fullscreen=True;A.root.attributes('-fullscreen',True);A.root.bind('<Escape>',A.toggle_fullscreen);A.root.bind('<F11>',A.toggle_fullscreen);A.root.bind('q',lambda e:A.on_close());A.root.bind('Q',lambda e:A.on_close());K=f"rtsp://{M}:{N}@{ip}:{P}/{Q}";A.cap=D.VideoCapture(K,D.CAP_FFMPEG);A.cap.set(D.CAP_PROP_BUFFERSIZE,1)
		if not A.cap.isOpened():L.showwarning('Stream',f"Could not open RTSP stream:\n{K}\n\nControls will still work; check the IP / network for video.")
		A.video_label=B.Label(J,bg='black',bd=0,highlightthickness=0);A.video_label.place(x=0,y=0,relwidth=1,relheight=1);A.panel=B.Frame(J,bg='#111',bd=0);A.panel.place(relx=0,rely=1.,anchor='sw',relwidth=1.)
		def C(parent,text,cmd,w=5,h=1,fontsize=14):return B.Button(parent,text=text,command=cmd,width=w,height=h,bg='#222',fg='#fff',activebackground='#444',font=('Helvetica',fontsize,'bold'),bd=1)
		E=B.Frame(A.panel,bg='#111');E.pack(side='left',padx=10,pady=6);C(E,'▲',lambda:A.ptz('up')).grid(row=0,column=1,padx=2,pady=2);C(E,'◀',lambda:A.ptz('left')).grid(row=1,column=0,padx=2,pady=2);C(E,'●',lambda:A.ptz('home')).grid(row=1,column=1,padx=2,pady=2);C(E,'▶',lambda:A.ptz('right')).grid(row=1,column=2,padx=2,pady=2);C(E,'▼',lambda:A.ptz('down')).grid(row=2,column=1,padx=2,pady=2);G=B.Frame(A.panel,bg='#111');G.pack(side='left',padx=10);C(G,'STOP',lambda:A.ptz('stop')).pack(side='left',padx=3);C(G,'HOME',lambda:A.ptz('home')).pack(side='left',padx=3);C(G,'POS',A.show_pos).pack(side='left',padx=3);F=B.Frame(A.panel,bg='#111');F.pack(side='left',padx=10);B.Label(F,text='Preset:',fg='#ccc',bg='#111').pack(side='left',padx=4);A.preset_var=B.StringVar(value='1');B.Entry(F,textvariable=A.preset_var,width=3).pack(side='left');C(F,'SET',A.set_preset).pack(side='left',padx=3);C(F,'GOTO',A.goto_preset).pack(side='left',padx=3);A.status=B.Label(A.panel,text='ready',fg='#0f0',bg='#111',anchor='e',font=('Courier',10));A.status.pack(side='right',padx=10);H.Thread(target=A._stream_loop,daemon=True).start();A._update_frame()
	def toggle_fullscreen(A,event=None):A.fullscreen=not A.fullscreen;A.root.attributes('-fullscreen',A.fullscreen)
	def ptz(C,direction):
		A=direction
		if A=='home':B='ptz_gohome'
		elif A=='stop':B='ptz_stop'
		elif A=='up':B=f"ptz_move tilt {G}"
		elif A=='down':B=f"ptz_move tilt -{G}"
		elif A=='left':B=f"ptz_move pan -{F}"
		elif A=='right':B=f"ptz_move pan {F}"
		else:return
		C._send(B,A)
	def _send(A,cmd,label):
		def B():B=S(A.ip,cmd);A.status.config(text=f"{label}: {B.strip()or"ok"}")
		H.Thread(target=B,daemon=True).start()
	def show_pos(A):
		def B():J(A.ip,'ptz_getpos',timeout=2);B=J(A.ip,'cat /var/ap/ptz_pos',timeout=2);A.status.config(text=B.strip()[:120]or'no position')
		H.Thread(target=B,daemon=True).start()
	def set_preset(A):A._send(f"ptz_set_preset {A.preset_var.get()}",'setpreset')
	def goto_preset(A):A._send(f"ptz_goto_preset {A.preset_var.get()}",'preset')
	def _stream_loop(A):
		while A.running:
			B,C=A.cap.read()
			if not B:time.sleep(.1);continue
			if A.frame_q.full():
				try:A.frame_q.get_nowait()
				except I.Empty:pass
			A.frame_q.put(C)
	def _update_frame(A):
		try:
			B=A.frame_q.get_nowait();B=D.cvtColor(B,D.COLOR_BGR2RGB);C=A.video_label.winfo_width();E=A.video_label.winfo_height()
			if C>10 and E>10:F,G=B.shape[:2];H=max(C/G,E/F);J,K=int(G*H),int(F*H);B=D.resize(B,(J,K));L=(J-C)//2;M=(K-E)//2;B=B[M:M+E,L:L+C]
			P=Image.fromarray(B);N=O.PhotoImage(P);A.video_label.imgtk=N;A.video_label.configure(image=N)
		except I.Empty:pass
		if A.running:A.root.after(30,A._update_frame)
	def on_close(A):
		A.running=False
		try:A.cap.release()
		except C:pass
		A.root.destroy()
def U():
	A=B.Tk();A.withdraw();A.attributes('-topmost',True);D=K.askstring('Camera IP','Enter camera IP (e.g. 192.168.1.6):',parent=A);A.destroy()
	if not D:print('No IP given, exiting.');return
	C=B.Tk();E=T(C,D.strip());C.protocol('WM_DELETE_WINDOW',E.on_close);C.mainloop()
if __name__=='__main__':U()
