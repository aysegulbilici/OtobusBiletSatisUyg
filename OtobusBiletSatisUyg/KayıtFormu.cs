using Npgsql;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace OtobusBiletSatisUyg
{
    public partial class KayıtFormu : Form
    {
        NpgsqlConnection conn;
        NpgsqlCommand comm;
        NpgsqlDataReader dr;
        String ad;
        String soyad;
        String tc;
        char cinsiyet='k';

        public KayıtFormu()
        {
            InitializeComponent();
            load();
        }

        private void load()
        {
            conn = new NpgsqlConnection("Server=localhost;Port=5432;Database=postgres;User Id=pattis; Password=pattis12;");
            conn.Open();
            comm = new NpgsqlCommand();
            comm.Connection = conn;
            conn.Close();
        }

        private void musteriEkle()
        {
            
            conn.Open();
            comm.CommandText = "insert into \"Musteri\" (\"tcNo\",ad,soyad,cinsiyet) values(" + tc + ",'" + ad + "','" + soyad + "','" + cinsiyet + "');";
            comm.ExecuteNonQuery();
            conn.Close();
        }

        private void musteriSil()
        {
            conn.Open();
            comm.CommandText = "delete from \"Musteri\" where \"tcNo\"="+ tc + ";";
            comm.ExecuteNonQuery();
            conn.Close();
        }
        private void maskedTextBox1_MaskInputRejected(object sender, MaskInputRejectedEventArgs e)
        {
            tc = maskedTextBox1.Text;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.Cancel;
            musteriSil();
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.DialogResult = DialogResult.OK;
            musteriEkle();
            this.Close();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            ad = textBox1.Text;
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            soyad = textBox2.Text;
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {
            if(radioButton2.Checked)
                cinsiyet = radioButton2.Text.ToLower()[0];
        }

        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
            if (radioButton1.Checked)
                cinsiyet = radioButton1.Text.ToLower()[0];
        }
    }
}
