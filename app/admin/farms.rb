ActiveAdmin.register Farm, as: "Exploitations" do
  before_action :remove_password_params_if_blank, only: [:update]
  permit_params :active, :name, :description, :address, :lagitude, :longitude, :opening_time, :country, :city, :iban, :zip_code, :farmer_number, :accepts_take_away, :user_id, :long_description, :delivery_delay, :accept_delivery, photos: [], labels: [], regions: [],
                opening_hours_attributes: [:id, :day, :opens, :closes],
                products_attributes: [:id, :active, :available_for_preorder, :name, :available, :category_id, :photo, :description, :ingredients, :unit, :fresh, :price_per_unit_cents, :price_per_unit_currency, :price_cents, :price_currency, :subtitle, :minimum_weight, :display_minimum_weight, :conditioning, :preorder, :total_weight, label:[] ],
                categories_attributes: [:id, :name],
                category_ids: [],
                user_attributes: [:id, :email, :first_name, :last_name, :number_phone, :wants_to_subscribe_mailing_list, :photo, :password, :title, :password_confirmation, :address_line_1, :city, :zip_code, :farm_id]

 LABELS = ["Bio-Suisse", "IP-Suisse", "Suisse Garantie", "AOP", "IPG", "Naturabeef", "Demeter", "Bio-Suisse Reconversion"]

  OFFICES = {
    "Aigle Distribution" => [1852, 1853, 1856, 1860, 1867, 1867, 1867 ],
    "Apples" => [1113, 1114, 1115, 1116, 1117, 1126, 1127, 1128, 1135, 1136, 1141, 1142, 1143, 1144, 1145, 1146, 1147, 1148, 1148, 1148, 1148, 1148, 1148, 1148, 1148, 1148, 1149],
    "Aubonne" => [1165, 1170, 1174, 1174, 1175, 1176],
    "Avenches Distribution" => [1564, 1580, 1580, 1580, 1583, 1584, 1585, 1585, 1585, 1586, 1587, 1587, 1588, 1589, 1595, 1595],
    "Bercher" => [1038, 1044, 1045, 1046, 1047],
    "Bernex Distribution" => [1232, 1233],
    "Bevaix" => [2022, 2023, 2024, 2025, 2027, 2027, 2028],
    "Bex Distribution" => [1880, 1880, 1880, 1880, 1880, 1882, 1884, 1884, 1884, 1885],
    "Biel/Bienne Zustellung" => [2502, 2502, 2503, 2503, 2504, 2504, 2505, 2505, 2512, 2532, 2532, 2533, 2533, 2534, 2534, 2535, 2536, 2537, 2538, 2552, 2555, 2556, 2556, 2557, 2558, 2560, 2562, 2563, 2564, 2565, 2572, 2572],
    "Blignou (Ayent" => [1966, 1966, 1966, 1966, 1966, 1966, 1966, 1966, 1966, 1966, 1971, 1971, 1972, 1974, 1977, 1978],
    "Bulle 1 Distribution" => [1625, 1625, 1626, 1626, 1626, 1627, 1628, 1630, 1632, 1633, 1633, 1638, 1642, 1643, 1644, 1645, 1646],
    "Bussigny Distribution" => [1029, 1030, 1031, 1034, 1035, 1036, 1302],
    "Carouge GE Distribution" => [1227, 1227, 1234, 1255, 1256],
    "Chailly-Montreux Distribution" => [1816, 1817, 1822, 1832, 1832, 1833, 1845, 1846],
    "Champéry" => [1872, 1873, 1873, 1873, 1874, 1875],
    "Château-d'Oex" => [1658, 1658, 1659, 1659, 1660, 1660, 1660, 1660],
    "Châtel-St-Denis Distribution" => [1611, 1614, 1615, 1616, 1617, 1617, 1618, 1619, 1623, 1624, 1624, 1624],
    "Chêne-Bourg Distribution" => [1224, 1225, 1226, 1231, 1241, 1243, 1251, 1252, 1254],
    "Cheseaux-sur-Lausanne Distribution" => [1032, 1033, 1037, 1054],
    "Chexbres Distribution" => [1070, 1071, 1071, 1071],
    "Collombey" => [1868, 1893, 1895, 1896, 1896, 1897, 1897, 1898, 1899],
    "Cologny Distribution" => [1223, 1253],
    "Colombier NE Distribution" => [2012, 2013, 2014, 2019, 2019],
    "Conthey Distribution" => [1955, 1955, 1955, 1955, 1955, 1955, 1957, 1962, 1963, 1964, 1975, 1976, 1976, 1976, 1994],
    "Coppet Distribution" => [1291, 1295, 1295, 1296],
    "Corcelles NE Distribution" => [2035, 2036, 2037, 2037],
    "Corgémont" => [2603, 2604, 2605, 2606, 2607, 2608, 2608, 2612],
    "Cortaillod" => [2015, 2016, 2017],
    "Courgenay" => [2882, 2883, 2884, 2885, 2886, 2887, 2888, 2889, 2946, 2947, 2950, 2950, 2952, 2953, 2953, 2954],
    "Courtepin" => [1721, 1721, 1721, 1721, 1783, 1783, 1783, 1783, 1784, 1784, 1784, 1785, 1791, 1791],
    "Couvet" => [2103, 2105, 2108, 2112, 2113, 2114, 2115, 2116, 2117, 2123, 2124, 2126, 2127, 2149, 2149, 2149],
    "Crissier 1 Distribution" => [1023, 1024],
    "Delémont 1 Distribution" => [2800, 2802, 2803, 2805, 2806, 2807, 2807, 2812, 2813, 2814, 2822, 2823, 2824, 2825, 2826, 2827, 2827, 2828, 2829, 2830, 2830, 2832, 2842, 2843, 2852, 2853, 2854, 2855, 2856, 2857, 2863, 2864, 2873],
    "Echallens Distribution" => [1040, 1040, 1040, 1041, 1041, 1041, 1041, 1041, 1041, 1042, 1042, 1042, 1043, 1375, 1376, 1376, 1376, 1377],
    "Evolène" => [1968, 1969, 1969, 1969, 1969, 1969, 1982, 1983, 1983, 1984, 1984, 1985, 1985, 1985],
    "Farvagny-le-Grand" => [1695, 1695, 1695, 1695, 1696, 1725, 1726, 1726, 1726, 1726, 1727, 1727, 1728, 1730, 1733],
    "Fétigny" => [1468, 1470, 1470, 1470, 1470, 1473, 1473, 1474, 1475, 1475, 1475, 1482, 1483, 1483, 1483, 1484, 1484, 1485, 1486, 1489, 1523, 1524, 1525, 1525, 1527, 1528, 1528, 1529, 1530, 1532, 1533, 1534, 1534, 1535, 1536, 1537, 1538, 1541, 1541, 1541, 1542, 1543, 1544, 1545, 1551, 1552, 1553, 1554, 1554, 1555, 1562, 1563, 1565, 1565, 1566, 1566, 1567, 1568],
    "Fontainemelon" => [2042, 2043, 2046, 2052, 2052, 2053, 2054, 2054, 2056, 2057, 2058, 2063, 2063, 2063, 2063, 2065, 2206, 2207, 2208],
    "Forel (Lavaux" => [1072, 1073, 1073],
    "Founex" => [1279, 1279, 1297, 1298, 1299],
    "Fribourg 1 Distribution" => [1700, 1720, 1720, 1722, 1723, 1723, 1723, 1724, 1724, 1724, 1724, 1724, 1724, 1724, 1724, 1724, 1731, 1732, 1752, 1753, 1762, 1763, 1782, 1782, 1782, 1782, 1782, 1782],
    "Froideville" => [1055, 1058],
    "Fully Distribution" => [1906, 1913, 1926],
    "Genève 15 Aéroport Dépôt" => [1215],
    "Genève 2 Distribution" => [1201, 1202, 1203, 1204, 1205, 1206, 1207, 1208, 1209],
    "Gingins" => [1263, 1274, 1274, 1275, 1276, 1277, 1277, 1278],
    "Gland Distribution" => [1182, 1183, 1184, 1184, 1187, 1188, 1188, 1189, 1195, 1195, 1196, 1261, 1261, 1261, 1264, 1265, 1267, 1267, 1268, 1268, 1269, 1272, 1273],
    "Grand-Lancy 1 Distribution" => [1212, 1228, 1257, 1258],
    "Grand-Saconnex Distribution" => [1216, 1218, 1292],
    "Grenchen 1 Zustellung" => [2540, 2542, 2543, 2544, 2545, 2553, 2554],
    "Gurmels" => [1792, 1792, 1793, 1794],
    "Haute-Nendaz" => [1993, 1993, 1996, 1996, 1996, 1996, 1996, 1996, 1996, 1996, 1997, 1997, 1997],
    "Hérémence" => [1981, 1987, 1988, 1988],
    "La Chaux-de-Fonds 1 Distribution" => [2300, 2300, 2322, 2325, 2333, 2333],
    "La Neuveville Distribution" => [2513, 2514, 2515, 2516, 2517, 2518, 2520, 2523, 2525],
    "La Tour-de-Trême" => [1634, 1635, 1636, 1637, 1647, 1648, 1649, 1651, 1652, 1652, 1653, 1653, 1654, 1656, 1656, 1657, 1661, 1663, 1663, 1663, 1663, 1665, 1666, 1666, 1667, 1669, 1669, 1669, 1669, 1669],
    "Lausanne 11 CHUV" => [1011],
    "Lausanne Distribution" => [1000, 1000, 1000, 1003, 1004, 1005, 1006, 1007, 1008, 1008, 1009, 1010, 1012, 1015, 1018, 1066, 1068, 1092],
    "Le Châble VS Distribution" => [1934, 1934, 1941, 1941, 1942, 1947, 1947, 1948, 1948, 1948],
    "Le Lignon Distribution" => [1219, 1219, 1219],
    "Le Locle Distribution" => [2314, 2316, 2316, 2318, 2400, 2400, 2405, 2406, 2406, 2406, 2406, 2414, 2416],
    "Le Mont-sur-Lausanne Distribution" => [1052, 1053, 1053],
    "Le Noirmont Distribution" => [2336, 2338, 2338, 2340, 2345, 2345, 2345, 2350, 2353, 2354, 2360, 2362, 2362, 2363, 2364],
    "Le Sentier Distribution" => [1341, 1342, 1343, 1344, 1345, 1345, 1346, 1347, 1347, 1348],
    "Leysin Distribution" => [1854, 1862, 1862, 1863, 1864, 1865, 1866],
    "Leytron" => [1908, 1911, 1912, 1912, 1912, 1912, 1918],
    "Lutry Distribution" => [1090, 1091, 1091, 1091, 1093, 1094, 1095, 1096, 1096, 1097, 1098],
    "Marin-Epagnier Distribution" => [2068, 2072, 2073, 2074, 2075, 2075, 2087, 2088],
    "Martigny 1 Distribution" => [1902, 1903, 1904, 1905, 1920, 1921, 1922, 1922, 1923, 1923, 1925, 1925, 1927, 1928, 1929, 1932, 1932],
    "Meyrin Distribution" => [1217, 1242, 1281, 1283, 1283],
    "Monthey 1 Distribution" => [1869, 1870, 1871, 1871, 1891],
    "Montreux 1 Distribution" => [1815, 1820, 1820, 1820, 1823, 1824, 1844, 1847],
    "Morges Distribution" => [1025, 1026, 1026, 1027, 1028, 1110, 1112, 1121, 1122, 1123, 1124, 1125, 1131, 1132, 1134, 1134],
    "Moudon Distribution" => [1063, 1063, 1063, 1063, 1410, 1410, 1410, 1410, 1410, 1509, 1510, 1510, 1512, 1513, 1513, 1514, 1515, 1515, 1521, 1522, 1522, 1526, 1526],
    "Moutier 1 Distribution" => [2740, 2742, 2743, 2744, 2745, 2746, 2747, 2747, 2748, 2748, 2762],
    "Murten Zustellung" => [1795, 1796, 1797],
    "Neuchâtel 2 Distribution" => [2000, 2034, 2067],
    "Nyon 1 Distribution" => [1197, 1260, 1262, 1266, 1270, 1271],
    "Orbe Distribution" => [1321, 1329, 1350, 1352, 1353, 1354, 1355, 1355, 1356, 1356, 1357, 1358, 1372, 1373, 1374],
    "Orsières" => [1933, 1933, 1933, 1933, 1937, 1938, 1943, 1944, 1945, 1945, 1945, 1945, 1945, 1945, 1945, 1945, 1945, 1945, 1946],
    "Palézieux Distribution" => [1076, 1077, 1078, 1080, 1083, 1084, 1085, 1607, 1607, 1607, 1607, 1608, 1608, 1608, 1608, 1610, 1610, 1610, 1612, 1613],
    "Penthalaz Distribution" => [1303, 1304, 1304, 1304, 1304, 1305, 1306, 1307, 1308, 1312, 1313, 1315, 1316, 1317, 1318],
    "Petit-Lancy Distribution" => [1213, 1213, 1236, 1237, 1284, 1285, 1286, 1287, 1288],
    "Plaffeien" => [1716, 1716, 1716, 1719, 1719, 1737, 1738],
    "Porrentruy 1 Distribution" => [2900, 2902, 2903, 2904, 2905, 2906, 2907, 2908, 2912, 2912, 2914, 2915, 2916, 2922, 2923, 2924, 2925, 2926, 2932, 2933, 2933, 2935, 2942, 2943, 2944],
    "Prez-vers-Noréaz" => [1740, 1741, 1742, 1744, 1745, 1746, 1747, 1748, 1749, 1754, 1754, 1756, 1756, 1757, 1772, 1772, 1772, 1773, 1773, 1773, 1774, 1774, 1775, 1775, 1776],
    "Reconvilier" => [2710, 2732, 2732, 2732, 2732, 2733, 2735, 2735, 2735, 2736, 2738],
    "Renens VD 1 Distribution" => [1020, 1022],
    "Rolle Distribution" => [1166, 1172, 1173, 1180, 1180, 1185, 1186],
    "Romont FR Distribution" => [1609, 1609, 1609, 1670, 1670, 1670, 1673, 1673, 1673, 1673, 1673, 1674, 1674, 1674, 1675, 1675, 1675, 1676, 1677, 1678, 1679, 1680, 1680, 1681, 1681, 1682, 1682, 1682, 1682, 1682, 1683, 1683, 1683, 1684, 1685, 1686, 1686, 1687, 1687, 1687, 1688, 1688, 1689, 1690, 1690, 1691, 1692, 1694, 1694, 1694, 1694, 1697, 1697, 1699, 1699, 1699],
    "Ropraz" => [1059, 1061, 1062, 1081, 1082, 1088],
    "Savièse Distribution" => [1965],
    "Saxon" => [1907, 1914, 1914],
    "Sion 1 Distribution" => [1950, 1958, 1958, 1961, 1967, 1973, 1991, 1991, 1991, 1991, 1991, 1992, 1992, 1992, 1992],
    "St-Imier Distribution" => [2610, 2610, 2610, 2610, 2613, 2615, 2615, 2616, 2616],
    "St-Légier/Blonay Distribution" => [1806, 1807],
    "St-Maurice" => [1890, 1890, 1892, 1892, 1892],
    "St-Prex Distribution" => [1162, 1163, 1164, 1167, 1168, 1169],
    "Sugiez" => [1786, 1787, 1787, 1787, 1788, 1789],
    "Tafers" => [1712, 1713, 1714, 1715, 1717, 1718, 1734, 1735, 1736],
    "Täuffelen" => [2575, 2575, 2575, 2576, 2577, 2577],
    "Tramelan Distribution" => [2712, 2713, 2714, 2715, 2715, 2716, 2717, 2717, 2718, 2718, 2720, 2720, 2722, 2723],
    "Vallorbe" => [1337, 1338],
    "Vaulion" => [1322, 1323, 1324, 1325, 1326],
    "Verbier" => [1936],
    "Vernier Distribution" => [1214, 1220],
    "Versoix Distribution" => [1239, 1290, 1290, 1293, 1294],
    "Vésenaz Distribution" => [1222, 1244, 1245, 1246, 1247, 1248],
    "Vevey 1 Distribution" => [1800, 1801, 1802, 1803, 1804, 1805, 1808, 1809, 1814],
    "Vuiteboeuf" => [1416, 1417, 1417, 1418, 1420, 1421, 1421, 1423, 1423, 1423, 1423, 1424, 1425, 1426, 1426, 1427, 1428, 1428, 1429, 1430, 1431, 1431, 1432, 1432, 1433, 1434, 1435, 1436, 1436, 1437, 1438, 1439, 1441, 1442, 1443, 1443, 1443, 1445, 1446, 1450, 1450, 1450, 1452, 1453, 1453, 1454, 1454],
    "Yverdon Distribution" => [1400, 1400, 1404, 1404, 1405, 1406, 1407, 1407, 1407, 1407, 1408, 1409, 1412, 1412, 1413, 1415, 1415, 1422, 1462, 1463, 1464, 1464]
  }

  actions :all

  index do
    actions defaults: true
    column :active
    column  "Nom", :name
    column "Propriétaire", :user do |col|
      col.user.first_name
    end
    column "Mail", :user do |col|
      col.user.email
    end
    column "Communes", :regions
    column "Délais préparation", :delivery_delay
  end

  filter :active, as: :boolean, label: "Active ?"
  filter :name, label: "Nom de l'exploitation"
  filter :user, label: "Propriétaire"
  filter :categories, label: "Catégories"
  filter :updated_at, label: "Dernière modification"


  form title: 'Exploitations' do |f|
    tabs do
      tab 'Etape 1' do
        panel 'Activer la ferme'do
          input :active, label: " Disponible ?"
        end
        panel 'Déclarer un Propriétaire' do
          f.input :user_id, as: :search_select, id: "select-user", url: search_users_admin_path,
          fields: [:first_name, :last_name, :email, :number_phone], display_name: :full_name, minimum_input_length: 3,
          order_by: 'description_asc', label: 'Chercher un propriétaire existant', clearable: false
          inputs "Informations du propriétaire", class: "owner-form", for: [:user, params[:id] ? Farm.find(params[:id]).user : User.new] do |u|
            u.input :title, collection: User::TITLE, label: "Genre"
            u.input :first_name, label: false, placeholder: "Prénom"
            u.input :last_name, label: false, placeholder: "Nom"
            u.input :email, label: false, placeholder: "Mail"
            u.input :number_phone, label: false, placeholder: "Téléphone"
            u.input :address_line_1, label: false, placeholder: "Adresse"
            u.input :city, label: false, placeholder: "Ville"
            u.input :zip_code, label: false, placeholder: "Code postal"
            u.input :password, label: false, placeholder: "Mot de passe"
            u.input :password_confirmation, label: false, placeholder: "Confirmation du mot de passe"
            u.input :wants_to_subscribe_mailing_list, label: "L'inscrire a la newsletter"
            u.input :photo, as: :file, label: "Mettre une photo de profil"
          end
        end
      end
      tab 'Etape 2' do
        panel "Renseigner les informations de l'exploitation" do
          inputs 'Coordonnées' do
            input :name, label: false, placeholder: "Dénomination"
            input :address, label: false, placeholder: "Adresse"
            input :zip_code, label: false, placeholder: "CP", :wrapper_html => { :class => 'fl' }
            input :city, label: false, placeholder: "Ville", :wrapper_html => { :class => 'fl' }
            input :country, label: false, :as => :string, placeholder: "Pays", :wrapper_html => { :class => 'fl' }
          end
          inputs 'Informations légales' do
            input :farmer_number, label: false, placeholder: "Numéro exploitant"
          end
          inputs 'Informations bancaires' do
            input :iban, label: false, placeholder: "IBAN"
          end
        end
      end
      tab 'Etape 3' do
        panel 'Créer la boutique' do
          inputs 'Description courte' do
            input :description, label: false
          end
          inputs 'Description longue' do
            input :long_description, label: false
          end
          inputs "Labels de l'exploitation" do
            input :labels, label: false, as: :check_boxes, collection: LABELS
          end
          inputs "Retrait a la ferme" do
            input :accepts_take_away, label: "Accepte le retrait à la ferme"
            f.has_many :opening_hours, heading: "", new_record: 'Ajouter une horaire' do |openning|
              openning.inputs do
                openning.input :day, label: "Jour", as: :select, collection: [["Lundi", 1], ["Mardi", 2], ["Mercredi", 3], ["Jeudi", 4], ["Vendredi", 5], ["Samedi", 6], ["Dimanche", 0]]
                openning.input :opens, label: "Ouverture"
                openning.input :closes, label: "Fermeture"
              end
            end
          end
          inputs 'Expéditions' do
            input :accept_delivery, label: "Accepte les expéditions"
          end
          inputs 'Délais de livraison' do
            input :delivery_delay, label: false
          end
          inputs "Horaires d'ouverture" do
            input :opening_time, label: false
          end
          inputs 'Offices de livraison' do
            input :regions, label: false, as: :check_boxes, collection: OFFICES
          end
          inputs 'Photos' do
            input :photos, as: :file, input_html: { multiple: true }, label: false
            input :photos, as: :file, input_html: { multiple: true }, label: false
            input :photos, as: :file, input_html: { multiple: true }, label: false
            input :photos, as: :file, input_html: { multiple: true }, label: false
            input :photos, as: :file, input_html: { multiple: true }, label: false
          end
        end
      end
      tab 'Etape 4' do
        panel 'Ajouter les catégorie' do
          f.input :category_ids, as: :check_boxes, collection: Category.all, label: false
        end
        panel "Produit(s) existant(s)" do
          table_for resource.products do
            column "Nom du produit", :name
            column "Catégorie du produit", :category, sortable: true
            column "Prix (CHF)", :price, sortable: true
            column "Actif", :active
            column do |produit|
              link_to 'Modifier', edit_admin_produit_path(produit), data: {confirm: 'Les modifications effectuées non sauvegardées seront perdues. Etes vous sûr de continuer ?'}
            end
          end
        end
        panel 'Créer un produit' do
          f.has_many :products, heading: "", new_record: 'Ajouter un produit' do |product|
            product.inputs do
              product.input :available, label: "Disponible ?"
              product.input :name, label: "Nom"
              product.input :category_id, as: :select, collection: Category.all, label: "Catégorie"
              product.input :price_cents, label: "Prix CHF"
              product.input :display_minimum_weight, label: "Afficher poids Minimum ?"
              product.input :minimum_weight, label: "Poids ou volume"
              product.input :unit, label: "Unité"
              product.input :price_per_unit_cents, label: "Prix au kg"
              product.input :conditioning, label: "Conditionnement"
              product.input :fresh, label: "Frais"
              product.input :label, label: false, as: :check_boxes, collection: LABELS, label: "Label"
              product.input :available_for_preorder, label: "Disponible en précommande"
              product.input :preorder, label: "Date livraison précommande"
              product.input :description, label: "Description"
              product.input :ingredients, label: "Ingrédients"
              product.input :photo, as: :file, label: "Image du produit"
              product.input :total_weight, label: "Poids total"
            end
          end
        end
      end
    end
    f.actions do
      if resource.persisted?
        f.action :submit, label: "Modifier l'exploitation"
      else
        f.action :submit, label: "Créer l'exploitation"
      end
    end
  end

  controller do
    def create
      @farm = Farm.new(permitted_params[:farm])
      @farm.user.skip_confirmation_notification!
      @farm.validate!
      @farm.products.each do |product|
        product.label.reject!(&:empty?)
      end

      @farm.labels.reject!(&:empty?)

      @farm.regions = @farm.regions.join(" ").split
      @farm.regions.reject!(&:empty?)

      if @farm.save
        redirect_to admin_exploitations_path, notice: "Resource created successfully."
      else
        render :new
      end
    end

    def update
      @farm = Farm.find(params[:id])
      params[:farm].delete(:user_id) if params[:farm][:user_id] == ""

      @farm.update!(permitted_params[:farm])
      @farm.labels.reject!(&:empty?)
      @farm.regions = @farm.regions.join(" ").split
      @farm.regions.reject!(&:empty?)

      if @farm.save
        redirect_to admin_exploitations_path
      else
        render :edit
      end

    end

    def remove_password_params_if_blank
      unless params[:farm][:user_attributes].nil?
        if params[:farm][:user_attributes][:password].blank? && params[:farm][:user_attributes][:password_confirmation].blank?
          params[:farm][:user_attributes].delete(:password)
          params[:farm][:user_attributes].delete(:password_confirmation)
        end
      end
    end

  end
end
