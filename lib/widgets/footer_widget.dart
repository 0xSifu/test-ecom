import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                color: Colors.white,
                child: const Text(
                  'UFO Elektronika adalah toko elektronik retail dengan jaringan cabang luas tersebar di berbagai penjuru strategis di Indonesia. Dengan memanfaatkan cakupan distribusi dan jaringan pemasaran yang luas, UFO Elektronika mampu menghadirkan layanan yang menguntungkan pelanggan, mulai dari harga yang sangat kompetitif hingga pengiriman gratis! UFO Elektronika menjual aneka barang elektronik, yaitu TV LED, Laptop, Perlengkapan Kantor, Telepon Genggam (Handphone), Aneka Gadget, Speaker, Home Theatre, Perlengkapan Elektronik Dapur, hingga Furniture dari brand-brand yang terpercaya dan berkualitas.',
                  textAlign: TextAlign.justify,
                ),
              ),
              const Divider(),
              /* ------------------------------- Newsletter ------------------------------- */
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Daftar untuk tetap mengikuti perkembangan tentang penawaran terpanas, produk baru paling keren, dan acara penjualan eksklusif.',
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Ketik Email Anda',
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB6B6B6)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0xFFB6B6B6)),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 48,
                        child: FilledButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.send),
                          label: const Text(
                            'Kirim',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),

        /* ---------------------------------- Menu ---------------------------------- */
        Theme(
          data: ThemeData(
            dividerColor: Colors.transparent,
            expansionTileTheme: const ExpansionTileThemeData(
              tilePadding: EdgeInsets.all(0),
              childrenPadding: EdgeInsets.only(bottom: 10),
              expandedAlignment: Alignment.topLeft,
              collapsedIconColor: Colors.black,
              iconColor: Colors.black,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            alignment: Alignment.topLeft,
            color: const Color(0xFFF5FAFE),
            child: Column(
              children: [
                /* ------------------------------- Footer menu ------------------------------ */
                const ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text(
                    'UFO Elektronika',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0060af),
                    ),
                  ),
                  children: [
                    Text('Lokasi Toko dan Service Center'),
                    SizedBox(height: 5),
                    Text('Syarat dan Ketentuan'),
                    SizedBox(height: 5),
                    Text('Kebijakan Privasi'),
                  ],
                ),
                const ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text(
                    'Informasi',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0060af),
                    ),
                  ),
                  children: [
                    Text('Keuntungan Member'),
                    SizedBox(height: 5),
                    Text('Garansi UFO PRO'),
                    SizedBox(height: 5),
                    Text('Instalasi'),
                    SizedBox(height: 5),
                    Text('Pengiriman'),
                    SizedBox(height: 5),
                    Text('Pengiriman'),
                  ],
                ),
                const ExpansionTile(
                  expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  title: Text(
                    'Customer Care',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0060af),
                    ),
                  ),
                  children: [
                    Text('Hubungi Customer Care'),
                    SizedBox(height: 5),
                    Text('Cara Belanja'),
                  ],
                ),
                const SizedBox(height: 20),

                /* ------------------------------- Icons list ------------------------------- */
                Container(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /* ---------------------------- Metode pembayaran --------------------------- */
                      const Text(
                        'Metode Pembayaran',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0060af),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                                  Image.asset('assets/icon/bank/logo-bca.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                                  Image.asset('assets/icon/bank/logo-bni.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child:
                                  Image.asset('assets/icon/bank/logo-bri.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/bank/logo-mandiri.webp'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      /* --------------------------- Keamanan transaksi --------------------------- */
                      const Text(
                        'Keamanan Transaksi',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0060af),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/security/logo-jcb.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/security/logo-mastersecure.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/security/logo-ssl.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/security/logo-visasecure.webp'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      /* ------------------------------- Ikuti kami ------------------------------- */
                      const Text(
                        'Ikuti Kami',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0060af),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/sosmed/icon-fb-color.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/sosmed/icon-ig-color.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/sosmed/icon-tiktok-color.webp'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 60,
                            height: 40,
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                  'assets/icon/sosmed/icon-youtube-color.webp'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
