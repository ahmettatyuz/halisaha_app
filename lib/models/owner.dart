class Owner {
  int id;
  String password;
  String pitchName;
  String ownerFirstName;
  String ownerLastName;
  String mail;
  String web;
  String phone;
  String city;
  String address;
  int point;
  String coordinate1;
  String coordinate2;
  DateTime createDate;

  static Map<String, String> turkishCities = {
    '01': 'Adana',
    '02': 'Adıyaman',
    '03': 'Afyonkarahisar',
    '04': 'Ağrı',
    '05': 'Amasya',
    '06': 'Ankara',
    '07': 'Antalya',
    '08': 'Artvin',
    '09': 'Aydın',
    '10': 'Balıkesir',
    '11': 'Bilecik',
    '12': 'Bingöl',
    '13': 'Bitlis',
    '14': 'Bolu',
    '15': 'Burdur',
    '16': 'Bursa',
    '17': 'Çanakkale',
    '18': 'Çankırı',
    '19': 'Çorum',
    '20': 'Denizli',
    '21': 'Diyarbakır',
    '22': 'Edirne',
    '23': 'Elazığ',
    '24': 'Erzincan',
    '25': 'Erzurum',
    '26': 'Eskişehir',
    '27': 'Gaziantep',
    '28': 'Giresun',
    '29': 'Gümüşhane',
    '30': 'Hakkari',
    '31': 'Hatay',
    '32': 'Isparta',
    '33': 'Mersin',
    '34': 'Istanbul',
    '35': 'İzmir',
    '36': 'Kars',
    '37': 'Kastamonu',
    '38': 'Kayseri',
    '39': 'Kırklareli',
    '40': 'Kırşehir',
    '41': 'Kocaeli',
    '42': 'Konya',
    '43': 'Kütahya',
    '44': 'Malatya',
    '45': 'Manisa',
    '46': 'Kahramanmaraş',
    '47': 'Mardin',
    '48': 'Muğla',
    '49': 'Muş',
    '50': 'Nevşehir',
    '51': 'Niğde',
    '52': 'Ordu',
    '53': 'Rize',
    '54': 'Sakarya',
    '55': 'Samsun',
    '56': 'Siirt',
    '57': 'Sinop',
    '58': 'Sivas',
    '59': 'Tekirdağ',
    '60': 'Tokat',
    '61': 'Trabzon',
    '62': 'Tunceli',
    '63': 'Şanlıurfa',
    '64': 'Uşak',
    '65': 'Van',
    '66': 'Yozgat',
    '67': 'Zonguldak',
    '68': 'Aksaray',
    '69': 'Bayburt',
    '70': 'Karaman',
    '71': 'Kırıkkale',
    '72': 'Batman',
    '73': 'Şırnak',
    '74': 'Bartın',
    '75': 'Ardahan',
    '76': 'Iğdır',
    '77': 'Yalova',
    '78': 'Karabük',
    '79': 'Kilis',
    '80': 'Osmaniye',
    '81': 'Düzce',
  };

  Owner({
    required this.id,
    required this.password,
    required this.pitchName,
    required this.ownerFirstName,
    required this.ownerLastName,
    required this.mail,
    required this.web,
    required this.phone,
    required this.city,
    required this.address,
    required this.point,
    required this.coordinate1,
    required this.coordinate2,
    required this.createDate,
  });
}