var apiKey = '******'; // TODO: API KEY AL
var baseurl = 'https://evds2.tcmb.gov.tr/service/evds/';

var supabaseurl = '********'; // app.supabase.io adresinden hesap aç
var supabasekey = '*********';

List<String> series = [
  'USD',
  'EUR',
  'ATS',
  'AUD',
  'BEF',
  'BGN',
  'CAD',
  'CHF',
  'CNY',
  'DEM',
  'DKK',
  'ECU',
  'ESP',
  'FIM',
  'FRF',
  'GBP',
  'GRD',
  'IEP',
  'IRR',
  'ITL',
  'JPY',
  'KWD',
  'LUF',
  'NLG',
  'NOK',
  'PKR',
  'PTE',
  'QAR',
  'RON',
  'RUB',
  'SAR',
  'SEK',
];

Map<String, String> seriesNames = {
  'USD': 'ABD Doları',
  'EUR': 'Euro',
  'ATS': 'Avusturya Şilini',
  'AUD': 'Avusturalya Doları',
  'BEF': 'Belçika Frangı',
  'BGN': 'Bulgar Levası',
  'CAD': 'Kanada Doları',
  'CHF': 'İsviçre Frangı',
  'CNY': 'Çin Yuanı',
  'DEM': 'Alman Markı',
  'DKK': 'Danimarka Kronu',
  'ECU': 'Ecu',
  'ESP': 'İspanyol Pezetası',
  'FIM': 'Finlandiya Markkası',
  'FRF': 'Fransız Frangı',
  'GBP': 'İngiltere Sterlini',
  'GRD': 'Yunan Drahmisi',
  'IEP': 'İrlanda Lirası',
  'IRR': '100 İran Riyali',
  'ITL': 'İtalyan Lireti',
  'JPY': 'Japon Yeni',
  'KWD': 'Kuveyt Dinarı',
  'LUF': 'Lüksemburg Frangı',
  'NLG': 'Hollanda Florini',
  'NOK': 'Norveç Kronu',
  'PKR': 'Pakistan Rupisi',
  'PTE': 'Portekiz Esküdosu',
  'QAR': 'Katar Riyali',
  'RON': 'Rumeny Leyi',
  'RUB': 'Rus Rublesi',
  'SAR': 'S.Arabistan Riyali',
  'SEK': 'İsveç Kronu',
};

List<String> predefinedQueries = [];

Map<String, String> aggregationTypes = {
  'Ortalama': 'avg',
  'En düşük': 'min',
  'En yüksek': 'max',
  'Başlangıç': 'first',
  'Bitiş': 'last',
  'Kümülatif': 'sum',
};

Map<String, String> formulas = {
  'Düzey': '0',
  'Yüzde değişim': '1',
  'Fark': '2',
  'Yıllık yüzde değişim': '3',
  'Yıllık fark': '4',
  'Bir önceki yılın sonuna göre yüzde değişim': '5',
  'Bir önceki yılın sonuna göre fark': '6',
  'Hareketli Ortalama': '7',
  'Hareketli Toplam': '8',
};

Map<String, String> frequency = {
  'Günlük': '1',
  'İş günü': '2',
  'Haftalık': '3',
  'Ayda 2 kez': '4',
  'Aylık': '5',
  '3 Aylık': '6',
  '6 Aylık': '7',
  'Yıllık': '8',
};
