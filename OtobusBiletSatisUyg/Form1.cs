using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Npgsql;

namespace OtobusBiletSatisUyg
{
    public partial class Form1 : Form
    {
        String musteri;
        String tc;
        char cinsiyet;
        String nereden;
        String nereye;
        int koltukNo;
        DateTime tarih;
        int fiyat;

        public Form1()
        {
            InitializeComponent();
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch(comboBox1.Text)
            {
                case "Nilüfer":KoltukDoldur(8, false);
                        break;
                case "KamilKoç":KoltukDoldur(12, true);
                        break;
                case "Kontur":KoltukDoldur(10, false);
                        break;

            }
            void KoltukDoldur(int sira, bool arkaBesliMi)
            {
                yavaslat:
                foreach(Control ctrl in this.Controls)
                {
                    if(ctrl is Button)
                    {
                        Button btn = ctrl as Button;
                        if(btn.Text=="Kaydet")
                        {
                            continue;
                        }
                        else
                        {
                            this.Controls.Remove(ctrl);
                            goto yavaslat;
                        }
                    }
                }
                int koltukNo = 1;
                for(int i=0;i<sira;i++)
                {
                    for(int j=0;j<5;j++)
                    {
                        if(arkaBesliMi==true)
                        {
                            if(i!=sira-1 && j==2)
                            {
                                continue;
                            }
                            else
                            {
                                if (j == 2)
                                    continue;
                            }
                        }
                      
                        Button koltuk = new Button();
                        koltuk.Height = koltuk.Width = 40;
                        koltuk.Top = 30 + (i * 45);
                        koltuk.Left = 5 + (j * 45);
                        koltuk.Text = koltukNo.ToString();
                        koltukNo++;
                        koltuk.ContextMenuStrip = contextMenuStrip1;
                        koltuk.MouseDown+=Koltuk_Mousedown;
                        this.Controls.Add(koltuk);

                    }
                }
            }
        }
        Button tiklanan;
        private void Koltuk_Mousedown(object sender, EventArgs e)
        {
            tiklanan = sender as Button;
        }

        private void dateTimePicker1_ValueChanged(object sender, EventArgs e)
        {

        }


        private void reserveEtToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (comboBox1.SelectedIndex == -1 || comboBox2.SelectedIndex == -1 || comboBox3.SelectedIndex == -1)
            {
                MessageBox.Show("Lütfen önce gerekli alanları doldurunuz");
                return;
            }
            KayıtFormu kf = new KayıtFormu();
            DialogResult sonuc = kf.ShowDialog();
            if (sonuc == DialogResult.OK)
            {
                ListViewItem lvi = new ListViewItem();
                lvi.Text = string.Format("{0} {1}", kf.textBox1.Text, kf.textBox2.Text);
                lvi.SubItems.Add(kf.maskedTextBox1.Text);
                if (kf.radioButton1.Checked)
                {
                    lvi.SubItems.Add("KADIN");
                    tiklanan.BackColor = Color.Red;
                }
                if (kf.radioButton2.Checked)
                {
                    lvi.SubItems.Add("ERKEK");
                    tiklanan.BackColor = Color.Blue;
                }
                lvi.SubItems.Add(comboBox2.Text);//musteri
                lvi.SubItems.Add(comboBox3.Text);//tc
                lvi.SubItems.Add(tiklanan.Text);
                lvi.SubItems.Add(dateTimePicker1.Text);
                lvi.SubItems.Add(numericUpDown1.Value.ToString());
                

                listView1.Items.Add(lvi);
            }
        }
    }
}
