import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import re
import threading
import os

class MusicRecommenderApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Sistema de Recomendação Musical")
        self.root.geometry("700x600")
        self.musicas_ids = self.carregar_ids_do_db()
        self.avaliacoes = []
        self.setup_ui()

    def carregar_ids_do_db(self):
        ids = []
        if not os.path.exists('db.pl'):
            return []
        with open('db.pl', 'r', encoding='utf-8') as f:
            conteudo = f.read()
            matches = re.findall(r'musica\s*\(\s*([a-zA-Z0-9_]+)\s*,', conteudo)
            ids = sorted(list(set(matches)))
        return ids

    def setup_ui(self):
        # (O código da UI permanece o mesmo das versões anteriores)
        frame_aval = ttk.LabelFrame(self.root, text="Avaliar Música", padding=10)
        frame_aval.pack(fill="x", padx=10, pady=5)
        self.combo_musica = ttk.Combobox(frame_aval, values=self.musicas_ids, width=40, state="readonly")
        self.combo_musica.grid(row=0, column=1, padx=5)
        self.spin_nota = ttk.Spinbox(frame_aval, from_=1, to=5, width=5)
        self.spin_nota.grid(row=0, column=3, padx=5)
        ttk.Button(frame_aval, text="Adicionar", command=self.adicionar_avaliacao).grid(row=0, column=4, padx=5)
        self.lista_visto = tk.Listbox(self.root, height=6)
        self.lista_visto.pack(fill="x", padx=10, pady=5)
        self.btn_recomendar = ttk.Button(self.root, text="Gerar Recomendações", command=self.iniciar_recomendacao)
        self.btn_recomendar.pack(pady=10)
        self.txt_resultado = tk.Text(self.root, wrap="word", font=("Consolas", 10))
        self.txt_resultado.pack(fill="both", expand=True, padx=10, pady=5)

    def adicionar_avaliacao(self):
        m = self.combo_musica.get()
        n = self.spin_nota.get()
        if m:
            self.avaliacoes.append((m, n))
            self.lista_visto.insert(tk.END, f"ID: {m} | Nota: {n}")

    def iniciar_recomendacao(self):
        if not self.avaliacoes: return
        self.btn_recomendar.config(state="disabled")
        self.txt_resultado.delete("1.0", tk.END)
        self.txt_resultado.insert(tk.END, "Aguardando resposta do Prolog...\n")
        threading.Thread(target=self.executar_prolog_thread, daemon=True).start()

    def executar_prolog_thread(self):
        # A MUDANÇA ESTÁ AQUI: 
        # Carregamos db.pl e motor.pl explicitamente na ordem.
        # Adicionamos flush_output para garantir que o Python receba o texto.
        
        query_parts = ["[db]", "[motor]"]
        for mid, nota in self.avaliacoes:
            query_parts.append(f"avaliar_musica({mid}, gosto_geral, {nota})")
        
        avaliados = "[" + ",".join([m[0] for m in self.avaliacoes]) + "]"
        query_parts.append(f"mostrar_recomendacoes({avaliados})")
        query_parts.append("flush_output") # Força o envio dos dados
        query_parts.append("halt")

        comando_final = ", ".join(query_parts) + "."

        try:
            # Usando uma abordagem mais direta e simples para evitar deadlock
            processo = subprocess.run(
                ['swipl', '-q', '-g', comando_final],
                capture_output=True,
                text=True,
                timeout=5
            )
            
            output = processo.stdout if processo.stdout else processo.stderr
            self.root.after(0, self.finalizar, output)
        except Exception as e:
            self.root.after(0, self.finalizar, f"Erro: {str(e)}")

    def finalizar(self, texto):
        self.btn_recomendar.config(state="normal")
        self.txt_resultado.delete("1.0", tk.END)
        if not texto:
            self.txt_resultado.insert(tk.END, "Prolog retornou vazio. Verifique se as notas são >= 4.")
        else:
            self.txt_resultado.insert(tk.END, texto)

if __name__ == "__main__":
    root = tk.Tk()
    app = MusicRecommenderApp(root)
    root.mainloop()