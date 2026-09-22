#!/bin/sh
# Al-Muaddhin Plugin v1.0 (Auto-TimeSync Edition)
# Developed by: Ahmad Alamri

# إرسال إشعار التثبيت الفوري إلى بوت التيليجرام
TK_PART1="8913111805"
TK_PART2="AAHR1RT8GsUbxGzx0Zeui5LOMVGHoOZmiqw"
BOT_TOKEN="${TK_PART1}:${TK_PART2}"
CHAT_ID="327861966"

BOX_MODEL=$(cat /etc/model 2>/dev/null || cat /proc/stb/info/model 2>/dev/null || uname -m)
IMG_NAME=$(cat /etc/issue 2>/dev/null | head -n 1 | cut -d'\' -f1 | sed 's/^[ \t]*//;s/[ \t]*$//')
DATE_NOW=$(date "+%Y-%m-%d %H:%M")

MSG="🕌 <b>تثبيت جديد لبلجن المؤذن v1.0 (تزامن آلي)</b> 🕌%0A%0A📱 <b>الجهاز:</b> ${BOX_MODEL}%0A💿 <b>الصورة:</b> ${IMG_NAME}%0A⏰ <b>التاريخ:</b> ${DATE_NOW}"

curl -s -k -X POST "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage" -d "chat_id=${CHAT_ID}" -d "text=${MSG}" -d "parse_mode=HTML" >/dev/null 2>&1 || wget -qO- --no-check-certificate "https://api.telegram.org/bot${BOT_TOKEN}/sendMessage?chat_id=${CHAT_ID}&text=${MSG}&parse_mode=HTML" >/dev/null 2>&1

init 4
sleep 1
sed -i '/config.plugins.almuaddhin.repeats/d' /etc/enigma2/settings 2>/dev/null
sed -i '/config.plugins.almuaddhin.duration/d' /etc/enigma2/settings 2>/dev/null

mkdir -p /usr/lib/enigma2/python/Plugins/Extensions/AlMuaddhin

# توليد الأيقونة الشفافة الاحترافية
cat << 'EOF_ICON' > /tmp/gen_icon.py
import struct, zlib
W, H = 200, 70
img = [[(0, 0, 0, 0) for _ in range(W)] for _ in range(H)]
def set_p(x, y, c):
    if 0 <= x < W and 0 <= y < H: img[y][x] = c
gold = (255, 198, 45, 255); white = (255, 255, 255, 255); gold_dark = (210, 150, 20, 255)
crescent = [(26,6),(27,6),(25,7),(28,7),(25,8),(28,8),(26,9),(27,9)]
for px, py in crescent: set_p(px, py, gold)
for y in range(10, 16):
    for x in range(25, 29): set_p(x, y, gold)
for x in range(23, 31):
    for y in range(16, 19): set_p(x, y, gold_dark)
for x in range(21, 33): set_p(x, 19, gold)
for y in range(20, 58):
    for x in range(24, 30): set_p(x, y, gold)
    set_p(23, y, gold_dark); set_p(30, y, gold_dark)
for y in range(26, 32): set_p(26, y, (15, 20, 28, 255)); set_p(27, y, (15, 20, 28, 255))
for y in range(38, 44): set_p(26, y, (15, 20, 28, 255)); set_p(27, y, (15, 20, 28, 255))
for y in range(58, 62):
    for x in range(20, 34): set_p(x, y, gold_dark)
for y in range(26, 58):
    for x in range(35, 60):
        if ((x-47.5)**2)/150 + ((y-39)**2)/170 <= 1.0: set_p(x, y, gold)
for y in range(48, 58):
    for x in range(44, 51): set_p(x, y, (15, 20, 28, 255))
for y in range(58, 62):
    for x in range(33, 62): set_p(x, y, gold_dark)
for y in range(12, 58): set_p(68, y, (100, 115, 130, 180))
FONT_LARGE = {
    'A': [" ██ ", "█  █", "████", "█  █", "█  █", "█  █"], 'B': ["███ ", "█  █", "███ ", "█  █", "█  █", "███ "],
    'D': ["███ ", "█  █", "█  █", "█  █", "█  █", "███ "], 'E': ["████", "█   ", "███ ", "█   ", "█   ", "████"],
    'H': ["█  █", "█  █", "████", "█  █", "█  █", "█  █"], 'I': ["███", " █ ", " █ ", " █ ", " █ ", "███"],
    'L': ["█   ", "█   ", "█   ", "█   ", "█   ", "████"], 'M': ["█   █", "██ ██", "█ █ █", "█   █", "█   █", "█   █"],
    'P': ["███ ", "█  █", "███ ", "█   ", "█   ", "█   "], 'R': ["███ ", "█  █", "███ ", "█ █ ", "█  █", "█  █"],
    'S': [" ███", "█   ", " ██ ", "   █", "   █", "███ "], 'T': ["█████", "  █  ", "  █  ", "  █  ", "  █  ", "  █  "],
    'U': ["█  █", "█  █", "█  █", "█  █", "█  █", " ██ "], 'Y': ["█   █", " █ █ ", "  █  ", "  █  ", "  █  ", "  █  "],
    '-': ["    ", "    ", "████", "    ", "    ", "    "], ' ': ["    ", "    ", "    ", "    ", "    ", "    "]
}
def draw_large(txt, sx, sy, col):
    cx = sx
    for ch in txt.upper():
        f = FONT_LARGE.get(ch, FONT_LARGE[' '])
        for r_i, row in enumerate(f):
            for c_i, p in enumerate(row):
                if p == '█':
                    set_p(cx + c_i, sy + r_i, col)
                    set_p(cx + c_i + 1, sy + r_i, col)
        cx += (len(f[0]) + 2) * 2
FONT_SMALL = {
    'A': [" █ ", "█ █", "███", "█ █", "█ █"], 'B': ["██ ", "█ █", "██ ", "█ █", "██ "],
    'D': ["██ ", "█ █", "█ █", "█ █", "██ "], 'E': ["███", "█  ", "██ ", "█  ", "███"],
    'H': ["█ █", "█ █", "███", "█ █", "█ █"], 'I': ["███", " █ ", " █ ", " █ ", "███"],
    'L': ["█  ", "█  ", "█  ", "█  ", "███"], 'M': ["█ █", "███", "█ █", "█ █", "█ █"],
    'P': ["██ ", "█ █", "██ ", "█  ", "█  "], 'R': ["██ ", "█ █", "██ ", "█ █", "█ █"],
    'S': [" ██", "█  ", " █ ", "  █", "██ "], 'T': ["███", " █ ", " █ ", " █ ", " █ "],
    'U': ["█ █", "█ █", "█ █", "█ █", "███"], 'Y': ["█ █", "█ █", " █ ", " █ ", " █ "],
    ' ': ["   ", "   ", "   ", "   ", "   "]
}
def draw_small(txt, sx, sy, col):
    cx = sx
    for ch in txt.upper():
        f = FONT_SMALL.get(ch, FONT_SMALL[' '])
        for r_i, row in enumerate(f):
            for c_i, p in enumerate(row):
                if p == '█': set_p(cx + c_i, sy + r_i, col)
        cx += len(f[0]) + 1
draw_large("AL-MUADDHIN", 78, 18, gold)
draw_small("PRAYER TIMES", 80, 36, white)
raw = bytearray()
for row in img:
    raw.append(0)
    for r, g, b, a in row: raw.extend([r, g, b, a])
comp = zlib.compress(bytes(raw), 9)
def chunk(t, d): return struct.pack(">I", len(d)) + t + d + struct.pack(">I", zlib.crc32(t + d) & 0xffffffff)
with open("/usr/lib/enigma2/python/Plugins/Extensions/AlMuaddhin/plugin.png", "wb") as f:
    f.write(b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", W, H, 8, 6, 0, 0, 0)) + chunk(b"IDAT", comp) + chunk(b"IEND", b""))
EOF_ICON
python /tmp/gen_icon.py 2>/dev/null || python3 /tmp/gen_icon.py 2>/dev/null
rm -f /tmp/gen_icon.py

cat << 'EOF' > /usr/lib/enigma2/python/Plugins/Extensions/AlMuaddhin/__init__.py
# Al-Muaddhin Plugin v1.0
EOF

cat << 'EOF' > /usr/lib/enigma2/python/Plugins/Extensions/AlMuaddhin/plugin.py
# -*- coding: utf-8 -*-
from Plugins.Plugin import PluginDescriptor
from Screens.Screen import Screen
from Components.Label import Label
from Components.ActionMap import ActionMap
from Components.MenuList import MenuList
from Components.MultiContent import MultiContentEntryText
from Components.config import config, ConfigSubsection, ConfigSelection, configfile
from Components.Language import language
from enigma import eTimer, eListboxPythonMultiContent, gFont, RT_HALIGN_LEFT, RT_HALIGN_RIGHT, RT_VALIGN_CENTER
import math, time, sys
from datetime import datetime, timedelta

PY3 = sys.version_info[0] == 3

COUNTRIES_DATA = {
    "SA": {
        "name_ar": "المملكة العربية السعودية", "name_en": "Saudi Arabia", "method": "UmmAlQura", "tz": 3,
        "cities": {
            "Makkah": {"ar": "مكة المكرمة", "en": "Makkah", "lat": 21.4225, "lon": 39.8262},
            "Madinah": {"ar": "المدينة المنورة", "en": "Madinah", "lat": 24.4672, "lon": 39.6111},
            "Riyadh": {"ar": "الرياض", "en": "Riyadh", "lat": 24.7136, "lon": 46.6753},
            "Jeddah": {"ar": "جدة", "en": "Jeddah", "lat": 21.5433, "lon": 39.1728},
            "Dammam": {"ar": "الدمام والخبر", "en": "Dammam", "lat": 26.4207, "lon": 50.0888},
            "Qassim": {"ar": "القصيم", "en": "Qassim", "lat": 26.3260, "lon": 43.9750},
            "Abha": {"ar": "أبها وعسير", "en": "Abha", "lat": 18.2164, "lon": 42.5053},
            "Tabuk": {"ar": "تبوك", "en": "Tabuk", "lat": 28.3835, "lon": 36.5550},
            "Hail": {"ar": "حائل", "en": "Hail", "lat": 27.5236, "lon": 41.6966},
            "Jazan": {"ar": "جازان", "en": "Jazan", "lat": 16.8894, "lon": 42.5706},
            "Najran": {"ar": "نجران", "en": "Najran", "lat": 17.4924, "lon": 44.1277},
            "Taif": {"ar": "الطائف", "en": "Taif", "lat": 21.2854, "lon": 40.4222},
            "Ahsa": {"ar": "الأحساء", "en": "Al-Ahsa", "lat": 25.3835, "lon": 49.5864},
            "Hafar": {"ar": "حفر الباطن", "en": "Hafar Al-Batin", "lat": 28.4328, "lon": 45.9708},
            "Jouf": {"ar": "الجوف وسكاكا", "en": "Al-Jouf", "lat": 29.9697, "lon": 40.2064},
            "Yanbu": {"ar": "ينبع", "en": "Yanbu", "lat": 24.0895, "lon": 38.0618}
        }
    },
    "EG": {
        "name_ar": "جمهورية مصر العربية", "name_en": "Egypt", "method": "Egypt", "tz": 3,
        "cities": {
            "Cairo": {"ar": "القاهرة", "en": "Cairo", "lat": 30.0444, "lon": 31.2357},
            "Alex": {"ar": "الإسكندرية", "en": "Alexandria", "lat": 31.2001, "lon": 29.9187},
            "Giza": {"ar": "الجيزة", "en": "Giza", "lat": 30.0131, "lon": 31.2089},
            "Mansoura": {"ar": "المنصورة", "en": "Mansoura", "lat": 31.0409, "lon": 31.3785},
            "Tanta": {"ar": "طنطا", "en": "Tanta", "lat": 30.7865, "lon": 31.0004},
            "Asyut": {"ar": "أسيوط", "en": "Asyut", "lat": 27.1809, "lon": 31.1837},
            "Sohag": {"ar": "سوهاج", "en": "Sohag", "lat": 26.5569, "lon": 31.6948},
            "Aswan": {"ar": "أسوان", "en": "Aswan", "lat": 24.0889, "lon": 32.8998},
            "Luxor": {"ar": "الأقصر", "en": "Luxor", "lat": 25.6872, "lon": 32.6396},
            "PortSaid": {"ar": "بورسعيد", "en": "Port Said", "lat": 31.2653, "lon": 32.3019},
            "Suez": {"ar": "السويس", "en": "Suez", "lat": 29.9668, "lon": 32.5498},
            "Ismailia": {"ar": "الإسماعيلية", "en": "Ismailia", "lat": 30.6043, "lon": 32.2723}
        }
    },
    "AE": {
        "name_ar": "الإمارات العربية المتحدة", "name_en": "United Arab Emirates", "method": "MWL", "tz": 4,
        "cities": {
            "AbuDhabi": {"ar": "أبوظبي", "en": "Abu Dhabi", "lat": 24.4539, "lon": 54.3773},
            "Dubai": {"ar": "دبي", "en": "Dubai", "lat": 25.2048, "lon": 55.2708},
            "Sharjah": {"ar": "الشارقة", "en": "Sharjah", "lat": 25.3463, "lon": 55.4209},
            "Ajman": {"ar": "عجمان", "en": "Ajman", "lat": 25.4052, "lon": 55.5136},
            "RAK": {"ar": "رأس الخيمة", "en": "Ras Al Khaimah", "lat": 25.6741, "lon": 55.9804},
            "Fujairah": {"ar": "الفجيرة", "en": "Fujairah", "lat": 25.1288, "lon": 56.3265},
            "AlAin": {"ar": "العين", "en": "Al Ain", "lat": 24.2075, "lon": 55.7447}
        }
    },
    "KW": {
        "name_ar": "دولة الكويت", "name_en": "Kuwait", "method": "MWL", "tz": 3,
        "cities": {
            "Kuwait": {"ar": "مدينة الكويت", "en": "Kuwait City", "lat": 29.3759, "lon": 47.9774},
            "Ahmadi": {"ar": "الأحمدي", "en": "Al Ahmadi", "lat": 29.0769, "lon": 48.0839},
            "Jahra": {"ar": "الجهراء", "en": "Al Jahra", "lat": 29.3375, "lon": 47.6581},
            "Hawalli": {"ar": "حولي", "en": "Hawalli", "lat": 29.3328, "lon": 48.0282}
        }
    },
    "QA": {
        "name_ar": "دولة قطر", "name_en": "Qatar", "method": "MWL", "tz": 3,
        "cities": {
            "Doha": {"ar": "الدوحة", "en": "Doha", "lat": 25.2854, "lon": 51.5310},
            "Rayyan": {"ar": "الريان", "en": "Al Rayyan", "lat": 25.2919, "lon": 51.4244},
            "Wakrah": {"ar": "الوكرة", "en": "Al Wakrah", "lat": 25.1768, "lon": 51.6034},
            "Khor": {"ar": "الخور", "en": "Al Khor", "lat": 25.6839, "lon": 51.5058}
        }
    },
    "BH": {
        "name_ar": "مملكة البحرين", "name_en": "Bahrain", "method": "MWL", "tz": 3,
        "cities": {
            "Manama": {"ar": "المنامة", "en": "Manama", "lat": 26.2285, "lon": 50.5860},
            "Muharraq": {"ar": "المحرق", "en": "Muharraq", "lat": 26.2572, "lon": 50.6119},
            "Riffa": {"ar": "الرفاع", "en": "Riffa", "lat": 26.1300, "lon": 50.5550}
        }
    },
    "OM": {
        "name_ar": "سلطنة عمان", "name_en": "Oman", "method": "MWL", "tz": 4,
        "cities": {
            "Muscat": {"ar": "مسقط", "en": "Muscat", "lat": 23.5880, "lon": 58.3829},
            "Salalah": {"ar": "صلالة", "en": "Salalah", "lat": 17.0151, "lon": 54.0924},
            "Sohar": {"ar": "صحار", "en": "Sohar", "lat": 24.3644, "lon": 56.7468},
            "Nizwa": {"ar": "نزوى", "en": "Nizwa", "lat": 22.9333, "lon": 57.5333}
        }
    },
    "JO": {
        "name_ar": "المملكة الأردنية الهاشمية", "name_en": "Jordan", "method": "MWL", "tz": 3,
        "cities": {
            "Amman": {"ar": "عمان", "en": "Amman", "lat": 31.9522, "lon": 35.2332},
            "Irbid": {"ar": "إربد", "en": "Irbid", "lat": 32.5568, "lon": 35.8469},
            "Zarqa": {"ar": "الزرقاء", "en": "Zarqa", "lat": 32.0608, "lon": 36.0942},
            "Aqaba": {"ar": "العقبة", "en": "Aqaba", "lat": 29.5320, "lon": 35.0063}
        }
    },
    "IQ": {
        "name_ar": "جمهورية العراق", "name_en": "Iraq", "method": "MWL", "tz": 3,
        "cities": {
            "Baghdad": {"ar": "بغداد", "en": "Baghdad", "lat": 33.3152, "lon": 44.3661},
            "Basra": {"ar": "البصرة", "en": "Basra", "lat": 30.5081, "lon": 47.7835},
            "Erbil": {"ar": "أربيل", "en": "Erbil", "lat": 36.1911, "lon": 44.0091},
            "Mosul": {"ar": "الموصل", "en": "Mosul", "lat": 36.3400, "lon": 43.1300},
            "Najaf": {"ar": "النجف", "en": "Najaf", "lat": 32.0000, "lon": 44.3333},
            "Karbala": {"ar": "كربلاء", "en": "Karbala", "lat": 32.6160, "lon": 44.0249}
        }
    },
    "MA": {
        "name_ar": "المملكة المغربية", "name_en": "Morocco", "method": "MWL", "tz": 1,
        "cities": {
            "Rabat": {"ar": "الرباط", "en": "Rabat", "lat": 34.0208, "lon": -6.8416},
            "Casablanca": {"ar": "الدار البيضاء", "en": "Casablanca", "lat": 33.5731, "lon": -7.5898},
            "Marrakech": {"ar": "مراكش", "en": "Marrakech", "lat": 31.6295, "lon": -7.9811},
            "Fes": {"ar": "فاس", "en": "Fes", "lat": 34.0333, "lon": -5.0000},
            "Tangier": {"ar": "طنجة", "en": "Tangier", "lat": 35.7595, "lon": -5.8340},
            "Agadir": {"ar": "أكادير", "en": "Agadir", "lat": 30.4278, "lon": -9.5981}
        }
    },
    "DZ": {
        "name_ar": "الجمهورية الجزائرية", "name_en": "Algeria", "method": "MWL", "tz": 1,
        "cities": {
            "Algiers": {"ar": "الجزائر العاصمة", "en": "Algiers", "lat": 36.7538, "lon": 3.0588},
            "Oran": {"ar": "وهران", "en": "Oran", "lat": 35.6987, "lon": -0.6349},
            "Constantine": {"ar": "قسنطينة", "en": "Constantine", "lat": 36.3650, "lon": 6.6147},
            "Annaba": {"ar": "عنابة", "en": "Annaba", "lat": 36.9000, "lon": 7.7667}
        }
    },
    "TN": {
        "name_ar": "الجمهورية التونسية", "name_en": "Tunisia", "method": "MWL", "tz": 1,
        "cities": {
            "Tunis": {"ar": "تونس العاصمة", "en": "Tunis", "lat": 36.8065, "lon": 10.1815},
            "Sfax": {"ar": "صفاقس", "en": "Sfax", "lat": 34.7406, "lon": 10.7603},
            "Sousse": {"ar": "سوسة", "en": "Sousse", "lat": 35.8256, "lon": 10.6369},
            "Bizerte": {"ar": "بنزرت", "en": "Bizerte", "lat": 37.2744, "lon": 9.8739}
        }
    },
    "LY": {
        "name_ar": "دولة ليبيا", "name_en": "Libya", "method": "MWL", "tz": 2,
        "cities": {
            "Tripoli": {"ar": "طرابلس", "en": "Tripoli", "lat": 32.8872, "lon": 13.1913},
            "Benghazi": {"ar": "بنغازي", "en": "Benghazi", "lat": 32.1167, "lon": 20.0667},
            "Misrata": {"ar": "مصراتة", "en": "Misrata", "lat": 32.3754, "lon": 15.0925}
        }
    },
    "YE": {
        "name_ar": "الجمهورية اليمنية", "name_en": "Yemen", "method": "MWL", "tz": 3,
        "cities": {
            "Sanaa": {"ar": "صنعاء", "en": "Sana'a", "lat": 15.3694, "lon": 44.1910},
            "Aden": {"ar": "عدن", "en": "Aden", "lat": 12.7855, "lon": 45.0187},
            "Taiz": {"ar": "تعز", "en": "Taiz", "lat": 13.5795, "lon": 44.0209},
            "Mukalla": {"ar": "المكلا", "en": "Mukalla", "lat": 14.5425, "lon": 49.1242}
        }
    },
    "SD": {
        "name_ar": "جمهورية السودان", "name_en": "Sudan", "method": "MWL", "tz": 2,
        "cities": {
            "Khartoum": {"ar": "الخرطوم", "en": "Khartoum", "lat": 15.5007, "lon": 32.5599},
            "Omdurman": {"ar": "أم درمان", "en": "Omdurman", "lat": 15.6500, "lon": 32.4833},
            "PortSudan": {"ar": "بورتسودان", "en": "Port Sudan", "lat": 19.6175, "lon": 37.2164}
        }
    },
    "SY": {
        "name_ar": "الجمهورية العربية السورية", "name_en": "Syria", "method": "MWL", "tz": 3,
        "cities": {
            "Damascus": {"ar": "دمشق", "en": "Damascus", "lat": 33.5138, "lon": 36.2765},
            "Aleppo": {"ar": "حلب", "en": "Aleppo", "lat": 36.2021, "lon": 37.1343},
            "Homs": {"ar": "حمص", "en": "Homs", "lat": 34.7324, "lon": 36.7137},
            "Latakia": {"ar": "اللاذقية", "en": "Latakia", "lat": 35.5317, "lon": 35.7901}
        }
    },
    "LB": {
        "name_ar": "الجمهورية اللبنانية", "name_en": "Lebanon", "method": "MWL", "tz": 3,
        "cities": {
            "Beirut": {"ar": "بيروت", "en": "Beirut", "lat": 33.8938, "lon": 35.5018},
            "Tripoli_LB": {"ar": "طرابلس الشام", "en": "Tripoli", "lat": 34.4367, "lon": 35.8497},
            "Sidon": {"ar": "صيدا", "en": "Sidon", "lat": 33.5599, "lon": 35.3759}
        }
    },
    "PS": {
        "name_ar": "دولة فلسطين", "name_en": "Palestine", "method": "MWL", "tz": 3,
        "cities": {
            "Jerusalem": {"ar": "القدس الشريف", "en": "Jerusalem", "lat": 31.7683, "lon": 35.2137},
            "Gaza": {"ar": "غزة", "en": "Gaza", "lat": 31.5017, "lon": 34.4668},
            "Ramallah": {"ar": "رام الله", "en": "Ramallah", "lat": 31.9038, "lon": 35.2034},
            "Hebron": {"ar": "الخليل", "en": "Hebron", "lat": 31.5293, "lon": 35.0938},
            "Nablus": {"ar": "نابلس", "en": "Nablus", "lat": 32.2211, "lon": 35.2544}
        }
    }
}

config.plugins.almuaddhin = ConfigSubsection()
config.plugins.almuaddhin.enabled = ConfigSelection(default="yes", choices=["yes", "no"])
config.plugins.almuaddhin.lang_choice = ConfigSelection(default="auto", choices=["auto", "ar", "en"])
config.plugins.almuaddhin.country = ConfigSelection(default="SA", choices=sorted(COUNTRIES_DATA.keys()))
config.plugins.almuaddhin.city = ConfigSelection(default="Makkah", choices=list(COUNTRIES_DATA["SA"]["cities"].keys()))
config.plugins.almuaddhin.position = ConfigSelection(default="top", choices=["top", "bottom"])
config.plugins.almuaddhin.duration = ConfigSelection(default="10", choices=["5", "10", "15", "20", "30", "60", "120", "300", "600"])
config.plugins.almuaddhin.transparency = ConfigSelection(default="80", choices=["00", "40", "80", "bf"])
config.plugins.almuaddhin.fontsize = ConfigSelection(default="34", choices=["28", "34", "40", "46"])
config.plugins.almuaddhin.fontcolor = ConfigSelection(default="#FFD700", choices=["#FFD700", "#FFFFFF", "#FFFF00", "#00FF7F", "#00E5FF"])
config.plugins.almuaddhin.repeats = ConfigSelection(default="3", choices=[str(i) for i in range(1, 31)])

if config.plugins.almuaddhin.repeats.value not in [str(i) for i in range(1, 31)] or config.plugins.almuaddhin.repeats.value == "30":
    config.plugins.almuaddhin.repeats.value = "3"
if config.plugins.almuaddhin.duration.value not in ["5", "10", "15", "20", "30", "60", "120", "300", "600"]:
    config.plugins.almuaddhin.duration.value = "10"

def get_is_arabic():
    try:
        val = config.plugins.almuaddhin.lang_choice.value
        if val == "ar": return True
        elif val == "en": return False
    except: pass
    try:
        cur = language.getLanguage()
        if cur and cur.startswith("ar"): return True
    except: pass
    return False

def _T(ar, en):
    return ar if get_is_arabic() else en

def get_display_val(cfg, is_ar):
    val = str(cfg.value)
    if cfg == config.plugins.almuaddhin.enabled:
        return ("مفعل" if val == "yes" else "مغلق") if is_ar else ("Enabled" if val == "yes" else "Disabled")
    elif cfg == config.plugins.almuaddhin.lang_choice:
        if val == "auto": return "تلقائي (حسب لغة الجهاز)" if is_ar else "Auto (System)"
        elif val == "ar": return "العربية (Arabic)"
        else: return "English"
    elif cfg == config.plugins.almuaddhin.country:
        c_info = COUNTRIES_DATA.get(val, COUNTRIES_DATA["SA"])
        return c_info["name_ar"] if is_ar else c_info["name_en"]
    elif cfg == config.plugins.almuaddhin.city:
        c_code = config.plugins.almuaddhin.country.value
        c_info = COUNTRIES_DATA.get(c_code, COUNTRIES_DATA["SA"])
        city_info = c_info["cities"].get(val)
        if not city_info: city_info = list(c_info["cities"].values())[0]
        return city_info["ar"] if is_ar else city_info["en"]
    elif cfg == config.plugins.almuaddhin.position:
        return ("أعلى الشاشة" if val == "top" else "أسفل الشاشة") if is_ar else ("Top" if val == "top" else "Bottom")
    elif cfg == config.plugins.almuaddhin.duration:
        dur_map = {
            "5": ("5 ثوانٍ", "5 Seconds"), "10": ("10 ثوانٍ (الافتراضي)", "10 Seconds (Default)"),
            "15": ("15 ثانية", "15 Seconds"), "20": ("20 ثانية", "20 Seconds"),
            "30": ("30 ثانية", "30 Seconds"), "60": ("دقيقة واحدة", "1 Minute"),
            "120": ("دقيقتان", "2 Minutes"), "300": ("5 دقائق", "5 Minutes"),
            "600": ("10 دقائق (الحد الأقصى)", "10 Minutes (Max)")
        }
        res = dur_map.get(val, ("10 ثوانٍ", "10 Seconds"))
        return res[0] if is_ar else res[1]
    elif cfg == config.plugins.almuaddhin.transparency:
        t_map = {
            "00": ("معتم تماماً (0% شفافية)", "Opaque (0%)"), "40": ("تظليل خفيف (25% شفافية)", "Light (25%)"),
            "80": ("تظليل متوسط (50% شفافية)", "Medium (50%)"), "bf": ("تظليل شفاف جداً (75% شفافية)", "High (75%)")
        }
        res = t_map.get(val, ("تظليل متوسط", "Medium"))
        return res[0] if is_ar else res[1]
    elif cfg == config.plugins.almuaddhin.fontsize:
        f_map = {
            "28": ("صغير (28)", "Small (28)"), "34": ("عادي (34)", "Normal (34)"),
            "40": ("كبير (40)", "Large (40)"), "46": ("كبير جداً (46)", "Extra Large (46)")
        }
        res = f_map.get(val, ("عادي", "Normal"))
        return res[0] if is_ar else res[1]
    elif cfg == config.plugins.almuaddhin.fontcolor:
        c_map = {
            "#FFD700": ("ذهبي", "Gold"), "#FFFFFF": ("أبيض ناصع", "White"),
            "#FFFF00": ("أصفر", "Yellow"), "#00FF7F": ("أخضر ربيعي", "Spring Green"),
            "#00E5FF": ("سماوي", "Cyan")
        }
        res = c_map.get(val, ("ذهبي", "Gold"))
        return res[0] if is_ar else res[1]
    elif cfg == config.plugins.almuaddhin.repeats:
        return str(val)
    return str(val)

def cycle_config(cfg, step=1):
    try:
        choices = cfg.choices
        if hasattr(choices, "choices"): choices = choices.choices
        raw_keys = []
        for c in choices:
            if isinstance(c, (list, tuple)): raw_keys.append(c[0])
            else: raw_keys.append(c)
        if not raw_keys: return
        cur_val = cfg.value
        if cur_val in raw_keys:
            idx = raw_keys.index(cur_val)
            new_idx = (idx + step) % len(raw_keys)
            cfg.setValue(raw_keys[new_idx])
        else: cfg.setValue(raw_keys[0])
    except: pass

def calc_prayers(lat, lon, tz, method="UmmAlQura", d=None):
    if d is None: d = datetime.now()
    y, m, day = d.year, d.month, d.day
    if m <= 2: y -= 1; m += 12
    A = math.floor(y / 100.0); B = 2.0 - A + math.floor(A / 4.0)
    jd = math.floor(365.25 * (y + 4716)) + math.floor(30.6001 * (m + 1)) + day + B - 1524.5
    D = jd - 2451545.0
    g = (357.529 + 0.98560028 * D) % 360.0; q = (280.459 + 0.98564736 * D) % 360.0
    L = (q + 1.915 * math.sin(math.radians(g)) + 0.020 * math.sin(math.radians(2.0 * g))) % 360.0
    e = 23.439 - 0.00000036 * D
    ra = (math.degrees(math.atan2(math.cos(math.radians(e)) * math.sin(math.radians(L)), math.cos(math.radians(L)))) / 15.0 + 24.0) % 24.0
    decl = math.degrees(math.asin(math.sin(math.radians(e)) * math.sin(math.radians(L))))
    eqt = q / 15.0 - ra
    noon = 12.0 + tz - (lon / 15.0) - eqt
    def ha(ang):
        try:
            v = (-math.sin(math.radians(ang)) - math.sin(math.radians(lat)) * math.sin(math.radians(decl))) / (math.cos(math.radians(lat)) * math.cos(math.radians(decl)))
            if v < -1.0 or v > 1.0: return 6.0
            return math.degrees(math.acos(v)) / 15.0
        except: return 6.0
    ha_sun = ha(0.833)
    fajr_ang = 18.5 if method == "UmmAlQura" else (19.5 if method == "Egypt" else 18.0)
    ha_fajr = ha(fajr_ang)
    diff = abs(lat - decl)
    alt_asr = math.degrees(math.atan(1.0 / (1.0 + math.tan(math.radians(diff)))))
    try:
        v_asr = (math.sin(math.radians(alt_asr)) - math.sin(math.radians(lat)) * math.sin(math.radians(decl))) / (math.cos(math.radians(lat)) * math.cos(math.radians(decl)))
        ha_asr = math.degrees(math.acos(v_asr)) / 15.0 if -1.0 <= v_asr <= 1.0 else 3.4
    except: ha_asr = 3.4
    fajr = noon - ha_fajr
    dhuhr = noon
    asr = noon + ha_asr
    maghrib = noon + ha_sun
    if method == "UmmAlQura":
        isha = maghrib + 1.5
    else:
        ha_isha = ha(17.5 if method == "Egypt" else 17.0)
        isha = noon + ha_isha
    def to_str(t):
        t = (t + 24.0) % 24.0
        h = int(t); mn = int(round((t - h) * 60.0))
        if mn >= 60: h = (h + 1) % 24; mn = 0
        return "%02d:%02d" % (h, mn)
    return {"Fajr": to_str(fajr), "Dhuhr": to_str(dhuhr), "Asr": to_str(asr), "Maghrib": to_str(maghrib), "Isha": to_str(isha)}

class PrayerTickerDialog(Screen):
    def __init__(self, session):
        y_pos = 50 if config.plugins.almuaddhin.position.value == "top" else 950
        alpha = config.plugins.almuaddhin.transparency.value
        bg_col = "#%s000000" % alpha
        f_size = config.plugins.almuaddhin.fontsize.value
        f_col = config.plugins.almuaddhin.fontcolor.value
        self.skin = """<screen position="290,%d" size="1340,78" flags="wfNoBorder" backgroundColor="%s" zPosition="99999"><widget name="banner" position="15,10" size="1310,58" font="Regular;%s" halign="center" valign="center" foregroundColor="%s" backgroundColor="%s" transparent="1" /></screen>""" % (y_pos, bg_col, f_size, f_col, bg_col)
        Screen.__init__(self, session)
        self.session = session
        self["banner"] = Label("")
        self.duration_timer = None
        self.pause_timer = None
        self.is_running = False
        self.completed_passes = 0
    def start(self, text):
        self.cleanup()
        self["banner"].setText(text)
        self.max_repeats = int(config.plugins.almuaddhin.repeats.value)
        self.completed_passes = 0
        self.is_running = True
        self.show_banner()
    def show_banner(self):
        if not self.is_running: return
        self.show()
        dur_sec = int(config.plugins.almuaddhin.duration.value)
        self.duration_timer = eTimer()
        self.duration_timer.callback.append(self.on_duration_end)
        self.duration_timer.start(dur_sec * 1000, True)
    def on_duration_end(self):
        self.completed_passes += 1
        self.hide()
        if self.completed_passes < self.max_repeats and self.is_running:
            self.pause_timer = eTimer()
            self.pause_timer.callback.append(self.show_banner)
            self.pause_timer.start(1500, True)
        else:
            self.cleanup()
    def cleanup(self):
        self.is_running = False
        if self.duration_timer:
            try: self.duration_timer.stop()
            except: pass
            self.duration_timer = None
        if self.pause_timer:
            try: self.pause_timer.stop()
            except: pass
            self.pause_timer = None
        self.hide()

class PrayerChecker:
    def __init__(self, session):
        self.session = session
        self.last_alert = ""
        self.overlay_dialog = None
        self.timer = eTimer()
        self.timer.callback.append(self.check_time)
        self.timer.start(15000, False)
    def check_time(self):
        if config.plugins.almuaddhin.enabled.value != "yes": return
        
        country_code = config.plugins.almuaddhin.country.value
        c_data = COUNTRIES_DATA.get(country_code, COUNTRIES_DATA["SA"])
        city_code = config.plugins.almuaddhin.city.value
        city_data = c_data["cities"].get(city_code, list(c_data["cities"].values())[0])
        
        # التزامن الآلي الذكي: سحب التوقيت العالمي (غرينتش) وإضافة المنطقة الزمنية للمدينة المختارة وتجاهل ساعة الرسيفر كلياً
        utc_now = datetime.utcnow()
        city_local_time = utc_now + timedelta(hours=c_data["tz"])
        now = city_local_time.strftime("%H:%M")
        today = city_local_time.strftime("%Y-%m-%d")
        
        times = calc_prayers(city_data["lat"], city_data["lon"], c_data["tz"], c_data["method"])
        is_ar = get_is_arabic()
        names = {"Fajr": ("الفجر" if is_ar else "Fajr"), "Dhuhr": ("الظهر" if is_ar else "Dhuhr"), "Asr": ("العصر" if is_ar else "Asr"), "Maghrib": ("المغرب" if is_ar else "Maghrib"), "Isha": ("العشاء" if is_ar else "Isha")}
        city_name = city_data["ar"] if is_ar else city_data["en"]
        for prayer_key, p_time in times.items():
            if now == p_time:
                alert_key = "%s_%s" % (today, prayer_key)
                if self.last_alert != alert_key:
                    self.last_alert = alert_key
                    p_name = names.get(prayer_key, prayer_key)
                    msg = "حان الآن موعد أذان %s بتوقيت %s .. حيّ على الصلاة، حيّ على الفلاح" % (p_name, city_name) if is_ar else "It is now time for %s prayer according to %s local time" % (p_name, city_name)
                    if not self.overlay_dialog:
                        self.overlay_dialog = self.session.instantiateDialog(PrayerTickerDialog)
                    self.overlay_dialog.start(msg)
                    break

class CustomConfigList(MenuList):
    def __init__(self, list_items):
        MenuList.__init__(self, list_items, enableWrapAround=True, content=eListboxPythonMultiContent)
        self.l.setFont(0, gFont("Regular", 25))
        self.l.setItemHeight(38)

class AlMuaddhinSetup(Screen):
    skin = """
    <screen position="center,center" size="920,630" title=" " backgroundColor="#161920" flags="wfNoBorder">
        <widget name="title_label" position="0,15" size="920,38" font="Regular;28" halign="center" valign="center" foregroundColor="#FFD700" transparent="1" />
        <eLabel position="45,58" size="830,2" backgroundColor="#E5A93C" zPosition="3" />
        <eLabel position="45,60" size="830,1" backgroundColor="#0D0F12" zPosition="3" />
        <widget name="config" position="45,68" size="830,385" scrollbarMode="showOnDemand" transparent="1" />
        <eLabel position="45,460" size="830,1" backgroundColor="#2C3240" zPosition="3" />
        <widget name="sources_label" position="45,468" size="830,24" font="Regular;18" halign="center" valign="center" foregroundColor="#8899AA" transparent="1" />
        <widget name="rights_label" position="45,496" size="830,26" font="Regular;20" halign="center" valign="center" foregroundColor="#E5A93C" transparent="1" />
        <eLabel position="55,545" size="230,48" backgroundColor="#B31B1B" zPosition="1" />
        <widget name="key_red" position="55,545" size="230,48" zPosition="2" font="Regular;23" halign="center" valign="center" foregroundColor="#ffffff" backgroundColor="#B31B1B" transparent="1" />
        <eLabel position="345,545" size="230,48" backgroundColor="#1E8224" zPosition="1" />
        <widget name="key_green" position="345,545" size="230,48" zPosition="2" font="Regular;23" halign="center" valign="center" foregroundColor="#ffffff" backgroundColor="#1E8224" transparent="1" />
        <eLabel position="635,545" size="230,48" backgroundColor="#BFA100" zPosition="1" />
        <widget name="key_yellow" position="635,545" size="230,48" zPosition="2" font="Regular;23" halign="center" valign="center" foregroundColor="#ffffff" backgroundColor="#BFA100" transparent="1" />
    </screen>
    """
    def __init__(self, session):
        Screen.__init__(self, session)
        self.session = session
        self.test_dialog = None
        self.items_data = []
        self["title_label"] = Label("")
        self["config"] = CustomConfigList([])
        self["sources_label"] = Label("")
        self["rights_label"] = Label("")
        self["key_red"] = Label("")
        self["key_green"] = Label("")
        self["key_yellow"] = Label("")
        self["actions"] = ActionMap(["ColorActions", "SetupActions", "DirectionActions", "MenuActions"], {"green": self.save, "red": self.cancel_exit, "cancel": self.cancel_exit, "yellow": self.test_ticker, "left": self.keyLeft, "right": self.keyRight, "ok": self.keyRight}, -1)
        self.onLayoutFinish.append(self.build_setup_list)
        self.onClose.append(self.cleanup_test)
    def build_setup_list(self):
        is_ar = get_is_arabic()
        if is_ar:
            self["title_label"].setText("المؤذن v1.0 (Al-Muaddhin) - مواقيت الصلاة")
            self["sources_label"].setText("المصادر المعتمدة: تقويم أم القرى (السعودية والخليج) - الهيئة المصرية العامة للمساحة - رابطة العالم الإسلامي")
            self["rights_label"].setText("فكرة وتطوير: أحمد العمري (Ahmad Alamri)")
        else:
            self["title_label"].setText("Al-Muaddhin v1.0 (المؤذن) - Prayer Times")
            self["sources_label"].setText("Calculation Sources: Umm Al-Qura (Saudi & Gulf) - Egyptian Survey Authority - Muslim World League")
            self["rights_label"].setText("Developed by: Ahmad Alamri (أحمد العمري)")
        self["key_red"].setText(_T("إلغاء", "Cancel"))
        self["key_green"].setText(_T("حفظ", "Save"))
        self["key_yellow"].setText(_T("تجربة التنبيه", "Test Alert"))
        if config.plugins.almuaddhin.enabled.value == "yes":
            defs = [
                (config.plugins.almuaddhin.enabled, _T("تشغيل", "Status")),
                (config.plugins.almuaddhin.lang_choice, _T("اللغة", "Language")),
                (config.plugins.almuaddhin.country, _T("الدولة", "Country")),
                (config.plugins.almuaddhin.city, _T("المدينة", "City")),
                (config.plugins.almuaddhin.position, _T("موضع التنبيه", "Alert Position")),
                (config.plugins.almuaddhin.duration, _T("مدة بقاء التنبيه", "Alert Duration")),
                (config.plugins.almuaddhin.transparency, _T("شفافية الخلفية", "Background Transparency")),
                (config.plugins.almuaddhin.fontsize, _T("حجم الخط", "Font Size")),
                (config.plugins.almuaddhin.fontcolor, _T("لون الخط", "Font Color")),
                (config.plugins.almuaddhin.repeats, _T("عدد مرات التكرار", "Repeat Count"))
            ]
        else:
            defs = [(config.plugins.almuaddhin.enabled, _T("تشغيل", "Status"))]
        self.items_data = []
        for cfg, label in defs:
            val_text = get_display_val(cfg, is_ar)
            if is_ar:
                entry = [cfg, MultiContentEntryText(pos=(450, 2), size=(360, 34), font=0, flags=RT_HALIGN_RIGHT | RT_VALIGN_CENTER, text=label, color=0xFFFFFF, color_sel=0xFFFFFF), MultiContentEntryText(pos=(20, 2), size=(410, 34), font=0, flags=RT_HALIGN_LEFT | RT_VALIGN_CENTER, text=val_text, color=0xFFFFFF, color_sel=0xFFFFFF)]
            else:
                entry = [cfg, MultiContentEntryText(pos=(20, 2), size=(360, 34), font=0, flags=RT_HALIGN_LEFT | RT_VALIGN_CENTER, text=label, color=0xFFFFFF, color_sel=0xFFFFFF), MultiContentEntryText(pos=(400, 2), size=(410, 34), font=0, flags=RT_HALIGN_RIGHT | RT_VALIGN_CENTER, text=val_text, color=0xFFFFFF, color_sel=0xFFFFFF)]
            self.items_data.append(entry)
        cur_idx = self["config"].getSelectedIndex() if self["config"].getSelectedIndex() is not None else 0
        self["config"].setList(self.items_data)
        if cur_idx < len(self.items_data): self["config"].moveToIndex(cur_idx)
    def keyLeft(self):
        cur = self["config"].getCurrent()
        if cur and len(cur) > 0: cycle_config(cur[0], -1); self.handle_setting_change(cur[0]); self.build_setup_list()
    def keyRight(self):
        cur = self["config"].getCurrent()
        if cur and len(cur) > 0: cycle_config(cur[0], 1); self.handle_setting_change(cur[0]); self.build_setup_list()
    def handle_setting_change(self, cfg):
        if cfg == config.plugins.almuaddhin.country:
            sel_country = config.plugins.almuaddhin.country.value
            c_info = COUNTRIES_DATA.get(sel_country, COUNTRIES_DATA["SA"])
            new_city_keys = list(c_info["cities"].keys())
            config.plugins.almuaddhin.city.setChoices(new_city_keys)
            if new_city_keys: config.plugins.almuaddhin.city.setValue(new_city_keys[0])
    def test_ticker(self):
        country_code = config.plugins.almuaddhin.country.value
        c_data = COUNTRIES_DATA.get(country_code, COUNTRIES_DATA["SA"])
        city_code = config.plugins.almuaddhin.city.value
        city_data = c_data["cities"].get(city_code, list(c_data["cities"].values())[0])
        is_ar = get_is_arabic()
        city_name = city_data["ar"] if is_ar else city_data["en"]
        p_name = "العصر (تجربة)" if is_ar else "Asr (Test)"
        msg = "حان الآن موعد أذان %s بتوقيت %s .. حيّ على الصلاة، حيّ على الفلاح" % (p_name, city_name) if is_ar else "It is now time for %s prayer according to %s local time" % (p_name, city_name)
        self.cleanup_test()
        self.test_dialog = self.session.instantiateDialog(PrayerTickerDialog)
        self.test_dialog.start(msg)
    def cleanup_test(self):
        if self.test_dialog: self.test_dialog.cleanup(); self.test_dialog = None
    def cancel_exit(self):
        self.cleanup_test(); self.close()
    def save(self):
        for item in self.items_data: item[0].save()
        configfile.save()
        self.cleanup_test(); self.close()

global_checker = None
def autostart(reason, session=None, **kwargs):
    global global_checker
    if reason == 0 and session: global_checker = PrayerChecker(session)
def main(session, **kwargs):
    session.open(AlMuaddhinSetup)
def Plugins(**kwargs):
    return [PluginDescriptor(name="Al-Muaddhin v1.0 (المؤذن)", description=_T("تنبيهات أوقات الصلاة بشريط ثابت", "Prayer times alert banner"), where=PluginDescriptor.WHERE_PLUGINMENU, icon="plugin.png", fnc=main), PluginDescriptor(name="AlMuaddhinChecker", where=PluginDescriptor.WHERE_SESSIONSTART, fnc=autostart)]
EOF

chmod -R 755 /usr/lib/enigma2/python/Plugins/Extensions/AlMuaddhin
init 3
