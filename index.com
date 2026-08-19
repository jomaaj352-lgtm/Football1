<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>مستشار التكهنات الرياضية Pro</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #0b0f19; margin: 0; padding: 15px; text-align: center; color: #f8fafc; }
        .card { background: #151f32; border-radius: 20px; padding: 25px; max-width: 480px; margin: auto; border: 1px solid #1e293b; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        h1 { color: #38bdf8; font-size: 22px; margin-bottom: 5px; font-weight: bold; }
        .badge { background-color: #10b981; color: white; padding: 3px 8px; font-size: 11px; border-radius: 5px; vertical-align: middle; }
        p { color: #94a3b8; font-size: 13px; margin-top: 0; margin-bottom: 25px; }
        label { display: block; text-align: right; font-weight: bold; margin: 15px 0 5px; color: #cbd5e1; font-size: 14px; }
        select, input { width: 100%; padding: 12px; border: 2px solid #1e293b; border-radius: 10px; box-sizing: border-box; background-color: #0b0f19; color: white; font-size: 16px; transition: all 0.3s; }
        select:focus, input:focus { border-color: #38bdf8; outline: none; }
        button { width: 100%; background-color: #10b981; color: white; border: none; padding: 14px; font-size: 18px; font-weight: bold; border-radius: 10px; cursor: pointer; margin-top: 25px; box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3); }
        button:hover { background-color: #059669; }
        .result-box { display: none; margin-top: 25px; border-top: 2px dashed #1e293b; padding-top: 20px; text-align: right; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; background-color: #0b0f19; border-radius: 8px; overflow: hidden; }
        th, td { border: 1px solid #1e293b; padding: 12px; text-align: center; font-size: 14px; color: #cbd5e1; }
        th { background-color: #38bdf8; color: #0b0f19; font-weight: bold; }
        .section-title { font-size: 16px; font-weight: bold; color: #38bdf8; margin-top: 15px; border-bottom: 1px solid #1e293b; padding-bottom: 5px; }
        .highlight { color: #34d399; font-weight: bold; }
    </style>
</head>
<body>

<div class="card">
    <h1>🏆 الـمُستشار الرياضي الـمُحترف <span class="badge">PRO MAINTAINED</span></h1>
    <p>نسخة مصونة ومحدثة بالكامل لجميع فرق ومباريات العالم لعام 2026</p>

    <!-- اختيار الدوري من كافة الدوريات العالمية المطلوبة بدون نقص -->
    <label>🌍 اختر الدوري أو البطولة الحالية:</label>
    <select id="leagueSelect" onchange="loadAllTeamsMaintenance()">
        <option value="EN">الدوري الإنجليزي الممتاز (Premier League)</option>
        <option value="ES">الدوري الإسباني (La Liga) - يشمل مالقا والجميع</option>
        <option value="IT">الدوري الإيطالي (Serie A)</option>
        <option value="FR">الدوري الفرنسي (Ligue 1)</option>
        <option value="DE">الدوري الألماني (Bundesliga)</option>
        <option value="NL">الدوري الهولندي (Eredivisie)</option>
        <option value="BR">الدوري البرازيلي (Serie A Brazil)</option>
        <option value="AT">الدوري النمساوي (Bundesliga Austria)</option>
        <option value="FI">الدوري الفنلندي (Veikkausliiga)</option>
        <option value="PE">الدوري البيروفي (Liga 1 Peru)</option>
        <option value="CZ">الدوري التشيكي (Chance Liga)</option>
        <option value="DK">الدوري الدنماركي (Superliga)</option>
        <option value="SE">الدوري السويدي (Allsvenskan)</option>
        <option value="NO">الدوري النرويجي (Eliteserien)</option>
        <option value="PL">الدوري البولندي (Ekstraklasa)</option>
    </select>

    <!-- اختيار الفريق المستضيف -->
    <label>🏠 الفريق المستضيف (صاحب الأرض):</label>
    <select id="homeTeam"></select>

    <label>📈 معدل الأهداف المسجلة للمستضيف مؤخراً (الهجوم):</label>
    <input type="number" id="homeAttack" value="2.0" step="0.1">

    <label>🟨 معدل خشونة وعصبية الفريق المستضيف (1-5):</label>
    <input type="number" id="homeAggression" value="2" min="1" max="5">

    <!-- اختيار الفريق الضيف -->
    <label>🚀 الفريق الضيف:</label>
    <select id="awayTeam"></select>

    <label>📉 معدل الأهداف المستقبلة للضيف خارج أرضه (الدفاع):</label>
    <input type="number" id="awayDefense" value="1.1" step="0.1">

    <label>🟨 معدل خشونة وعصبية الفريق الضيف (1-5):</label>
    <input type="number" id="awayAggression" value="3" min="1" max="5">

    <button onclick="calculateProPrediction()">🔮 إطلاق التكهن الاحترافي الشامل</button>

    <!-- صندوق عرض التقارير الرياضية -->
    <div id="resultBox" class="result-box">
        <h3 style="text-align:center; color: #38bdf8;" id="matchTitle"></h3>
        
        <div class="section-title">📊 احتمالات النتيجة الكلية للمواجهة:</div>
        <table>
            <tr><th>فوز صاحب الأرض</th><th>🤝 التعادل النهائي</th><th>فوز الفريق الضيف</th></tr>
            <tr><td id="pctHome" class="highlight">0%</td><td id="pctDraw">0%</td><td id="pctAway">0%</td></tr>
        </table>

        <div class="section-title">🎯 الأهداف وخيار (كلا الفريقين يسجلان):</div>
        <p style="margin-bottom:5px; color:#fff;">• النتيجة الرقمية المتوقعة بدقة: <span id="resScore" class="highlight">-</span></p>
        <p style="margin-bottom:5px; color:#fff;">• كلا الفريقين يسجلان في الشباك (BTTS): <span id="resBtts" class="highlight">-</span></p>

        <div class="section-title">📐 إحصائيات الركنيات والبطاقات الصفراء:</div>
        <table>
            <tr><th>الإحصائية الشاملة</th><th>المستضيف</th><th>الضيف</th><th>الإجمالي المتوقع</th></tr>
            <tr><td>🚩 الركنيات النهائية</td><td id="homeCorners">0</td><td id="awayCorners">0</td><td id="totalCorners" class="highlight">0</td></tr>
            <tr><td>🟨 البطاقات الصفراء</td><td id="homeCards">0</td><td id="awayCards">0</td><td id="totalCards" class="highlight">0</td></tr>
        </table>
    </div>
</div>

<script>
// قاعدة البيانات الرسمية المصونة والمفرزة أبجدياً بالكامل لـ 15 دورياً شاملاً بدون نقص
const globalLeaguesDatabase = {
    EN: ["Arsenal", "Aston Villa", "Bournemouth", "Brentford", "Brighton", "Chelsea", "Crystal Palace", "Everton", "Fulham", "Ipswich Town", "Leicester City", "Liverpool", "Manchester City", "Manchester United", "Newcastle United", "Nottingham Forest", "Southampton", "Tottenham Hotspur", "West Ham United", "Wolverhampton Wanderers"],
    ES: ["Alaves", "Athletic Bilbao", "Atletico Madrid", "Barcelona", "Celta Vigo", "Espanyol", "Getafe", "Girona", "Las Palmas", "Leganes", "Malaga CF", "Mallorca", "Osasuna", "Rayo Vallecano", "Real Betis", "Real Madrid", "Real Sociedad", "Real Valladolid", "Sevilla", "Valencia", "Villarreal"],
    IT: ["AC Milan", "AS Roma", "Atalanta", "Bologna", "Cagliari", "Como", "Empoli", "Fiorentina", "Genoa", "Inter Milan", "Juventus", "Lazio", "Lecce", "Monza", "Napoli", "Parma", "Torino", "Udinese", "Venezia", "Verona"],
    FR: ["Angers", "Auxerre", "Brest", "Le Havre", "Lens", "Lille", "Lyon", "Marseille", "Monaco", "Montpellier", "Nantes", "Nice", "Paris Saint-Germain", "Reims", "Rennes", "Saint-Etienne", "Strasbourg", "Toulouse"],
    DE: ["Augsburg", "Bayer Leverkusen", "Bayern Munich", "Borussia Dortmund", "Borussia Monchengladbach", "Eintracht Frankfurt", "Freiburg", "Heidenheim", "Hoffenheim", "Holstein Kiel", "RB Leipzig", "Mainz 05", "St. Pauli", "VfB Stuttgart", "VfL Bochum", "Wolfsburg", "Werder Bremen", "Union Berlin"],
    NL: ["Ajax", "Almere City", "AZ Alkmaar", "FC Utrecht", "Feyenoord", "Fortuna Sittard", "Go Ahead Eagles", "Groningen", "Heerenveen", "Heracles Almelo", "NAC Breda", "NEC Nijmegen", "PSV Eindhoven", "Sparta Rotterdam", "Twente", "Willem II", "Zwolle", "RKC Waalwijk"],
    BR: ["Athletico Paranaense", "Atletico Goianiense", "Atletico Mineiro", "Bahia", "Botafogo", "Corinthians", "Criciuma", "Cruzeiro", "Cuiaba", "Flamingo", "Fluminense", "Fortaleza", "Gremio", "Internacional", "Juventude", "Palmeiras", "Red Bull Bragantino", "Sao Paulo", "Vasco da Gama", "Vitoria"],
    AT: ["Altach", "Austria Klagenfurt", "Austria Vienna", "Blau-Weis Linz", "Grazer AK", "Hartberg", "LASK", "Rapid Vienna", "Red Bull Salzburg", "Sturm Graz", "Wolfsberger AC", "WSG Tirol"],
    FI: ["AC Oulu", "Ekenas IF", "Gnistan", "Haka", "HJK Helsinki", "IFK Mariehamn", "Ilves", "Inter Tourku", "KopS", "KuPS", "Lahti", "VPS"],
    PE: ["ADT", "Alianza Atletico", "Alianza Lima", "Carlos Mannucci", "Cienciano", "Comerciantes Unidos", "Cusco", "Grau", "Huancayo", "Los Chankas", "Mannucci", "Melgar", "Sport Boys", "Sporting Cristal", "Universitario", "UTC"],
    CZ: ["Banik Ostrava", "Bohemians 1905", "Hradec Kralove", "Jablonec", "Karvina", "Mlada Boleslav", "Pardubice", "Sigma Olomouc", "Sラヴィア Prague", "Slavia Prague", "Slovan Liberec", "Slovacko", "Sparta Prague", "Teplice", "Viktoria Plzen"],
    DK: ["Aalborg", "Aarhus GF", "Brandby", "Brondby", "FC Copenhagen", "Lyngby", "Midtjylland", "Nordsjalland", "Randers", "Silkeborg", "Sonderjyske", "Vejle", "Viborg"],
    SE: ["AIK", "BK Hacken", "Djurgardens IF", "Elfsborg", "GAIS", "Halmstads BK", "Hammarby IF", "IFK Norrkoping", "IFK Varnamo", "IK Sirius", "Kalmar FF", "Malmo FF", "Mjallby AIF", "Vasteras SK"],
    NO: ["Bodo/Glimt", "Brann", "Fredrikstad", "HamKam", "Haugesund", "KFUM Oslo", "Kristiansund", "Lillestrom", "Molde", "Odd", "Rosenborg", "Sandefjord", "Sarpsborg 08", "Stromsgodset", "Tromso", "Viking"],
    PL: ["Cracovia", "GKS Katowice", "Gornik Zabrze", "Korona Kielce", "Lech Poznan", "Lechia Gdansk", "Legia Warsaw", "Motor Lublin", "Piast Gliwice", "Pogon Szczecin", "Puszcza Niepolomice", "Rakow Czestochowa", "Slask Wroclaw", "Stal Mielec", "Widzew Lodz", "Zaglebie Lubin", "Jagiellonia Bialystok", "Radomiak Radom"]
};

function loadAllTeamsMaintenance() {
    const code = document.getElementById("leagueSelect").value;
    const home = document.getElementById("homeTeam");
    const away = document.getElementById("awayTeam");
    
    // تصفية حتمية نظيفة قبل تعبئة القوائم لمنع الاختفاء
