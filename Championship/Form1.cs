using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.IO;
using System.Threading;
using System.Windows.Forms;
using System.Net; 

namespace Championship
{

public partial class Form1 : Form
{
HttpListener server;
bool flag = true;

    public Form1()
    {
        InitializeComponent();
    }

    private void button1_Click(object sender, EventArgs e)
    {
//запись адреса и порта
//в браузере для проверки открыть localhost с портом 8080 http://127.0.0.1:8080
//для доступа к серверу с другого устройства - ip сервера + порт 8080
        string uri = @"http://+:8080/";
        StartServer(uri);
    }

    private void StartServer(string prefix)
    {
        server = new HttpListener();
// проверка совместимости с HttpListener 
        if (!HttpListener.IsSupported) return;
        if (string.IsNullOrEmpty(prefix))
        throw new ArgumentException("prefix");
        server.Prefixes.Add(prefix);

//запуск сервера
        server.Start();
        this.Text = "Сервер запущен!";
        while (server.IsListening)
        {
//ожидание входящих запросов
            HttpListenerContext context = server.GetContext();
//получение запросов
            HttpListenerRequest request = context.Request;
            if (request.HttpMethod == "POST")
            {
            ShowRequestData(request);
            if (!flag) return;
            }
//формирование ответа сервера:
            string responseString = @"<!DOCTYPE HTML>
            <html><head></head><body>
            <form method=""post"" action=""say"">
            <p><b>Name: </b><br>
            <input type=""text"" name=""myname"" size=""40""></p>
            <p><input type=""submit"" value=""send""></p>
            </form></body></html>";
//отправка данных клиенту
            HttpListenerResponse response = context.Response;
            response.ContentType = "text/html; charset=UTF-8";
            byte[] buffer = Encoding.UTF8.GetBytes(responseString);
            response.ContentLength64 = buffer.Length;
            using (Stream output = response.OutputStream)
            {
            output.Write(buffer, 0, buffer.Length);
            }
        }
    }

    private void ShowRequestData(HttpListenerRequest request)
    {
//проверка получения данных
    if (!request.HasEntityBody) return;
    using (Stream body = request.InputStream)
        {
        using (StreamReader reader = new StreamReader(body))
        {
            string text = reader.ReadToEnd();
            text = text.Remove(0, 7);
//преобразование полученной строки
            text = WebUtility.UrlDecode(text);
//вывод полученного ответа

//остановка сервера по команде stop с клиента
            if (text == "stop")
            {
                server.Stop();
                this.Text = "Сервер остановлен!";
                flag = false;
            }
            else
            {
                MessageBox.Show("Ваше имя: " + text);
                flag = true;
            }
        }   
        }
    }
}
}
