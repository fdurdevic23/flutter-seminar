# Razvojno okruženje i životni ciklus Flutter aplikacije

Seminarski projekt za kolegij **Razvoj aplikacija za mobilne i pametne uređaje** na Fakultetu organizacije i informatike (FOI).

Projekt prikazuje pripremu Flutter razvojnog okruženja, izradu jednostavnog korisničkog sučelja, navigaciju između dvaju zaslona, pokretanje i testiranje aplikacije te praćenje životnog ciklusa Flutter aplikacije.

## Korištene tehnologije

- **Flutter** – framework za izradu aplikacija.
- **Dart** – programski jezik u kojem su napisani primjeri.
- **Visual Studio Code** – uređivanje koda, pokretanje i otklanjanje pogrešaka.
- **Android Studio i Android SDK** – alati potrebni za Android emulator i izgradnju Android aplikacije.
- **Android emulator ili fizički Android uređaj** – izvođenje i testiranje primjera.

## Struktura repozitorija

```text
Flutter-seminar/
├── README.md
└── flutter_lifecycle/
    ├── lib/
    │   └── main.dart                # Glavna aplikacija: navigacija i životni ciklus
    ├── primjeri/
    │   ├── widget_tree.dart         # Osnovna struktura widgeta
    │   ├── dva_zaslona.dart         # Navigacija i prijenos imena
    │   └── main_brojac.dart         # Brojač, Hot Reload, Hot Restart i debugging
    ├── android/                     # Android konfiguracija
    ├── ios/                         # Podrška za iOS
    ├── web/                         # Podrška za web
    ├── test/                        # Flutter testovi
    └── pubspec.yaml                 # Konfiguracija Flutter projekta
```

*Prikazane su glavne datoteke i mape. Flutter projekt sadrži i dodatne automatski generirane ili konfiguracijske datoteke.*

## Priprema razvojnog okruženja

1. Instalirati **Visual Studio Code**.
2. U VS Codeu instalirati proširenja **Flutter** i **Dart**.
3. Instalirati **Flutter SDK** i dodati ga u sistemski `PATH` kako bi naredba `flutter` bila dostupna u terminalu.
4. Instalirati **Android Studio** i potrebne komponente **Android SDK-a**.
5. U Android Studiju pripremiti virtualni Android uređaj (emulator) ili povezati fizički Android uređaj s omogućenim USB debuggingom.

U terminalu provjeriti konfiguraciju:

```powershell
flutter doctor
```

Naredba prikazuje koje su komponente uspješno postavljene i upozorava na eventualne nedostatke. Za izvođenje na Androidu ključan je ispravno konfiguriran **Android toolchain**. Upozorenje povezano s Visual Studio C++ alatima za Windows desktop razvoj ne znači nužno da Android razvoj nije moguć.

## Primjeri i način pokretanja

Svaka datoteka je samostalan demonstracijski primjer s vlastitom funkcijom `main()`.

| Primjer | Datoteka | Naredba |
| --- | --- | --- |
| Glavna aplikacija s praćenjem životnog ciklusa | [`lib/main.dart`](flutter_lifecycle/lib/main.dart) | `flutter run` |
| Widget tree | [`primjeri/widget_tree.dart`](flutter_lifecycle/primjeri/widget_tree.dart) | `flutter run -t primjeri/widget_tree.dart` |
| Dva zaslona | [`primjeri/dva_zaslona.dart`](flutter_lifecycle/primjeri/dva_zaslona.dart) | `flutter run -t primjeri/dva_zaslona.dart` |
| Brojač | [`primjeri/main_brojac.dart`](flutter_lifecycle/primjeri/main_brojac.dart) | `flutter run -t primjeri/main_brojac.dart` |

### 1. Struktura widgeta – `widget_tree.dart`

Ovaj primjer prikazuje hijerarhijsku organizaciju Flutterova korisničkog sučelja:

- `MaterialApp` je osnovni okvir aplikacije.
- `Scaffold` pruža strukturu zaslona.
- `AppBar` prikazuje naslovnu traku.
- `Center` i `Column` raspoređuju sadržaj.
- `Text` prikazuje tekst, a `FloatingActionButton` sadrži ikonu.

Plutajući gumb u ovom je primjeru **namjerno bez dodatne radnje** jer je cilj prikazati widget tree.

### 2. Dva zaslona – `dva_zaslona.dart`

Na prvom zaslonu korisnik upisuje ime u `TextField` i pritišće **Nastavi**.

- `TextEditingController` omogućuje dohvaćanje upisanog imena.
- Ako je polje prazno, prikazuje se poruka da treba unijeti ime.
- `Navigator.push()` otvara drugi zaslon i prosljeđuje uneseno ime.
- Drugi zaslon ispisuje pozdrav, primjerice **„Pozdrav, Ana! 👋”**.
- `Navigator.pop()` na gumbu **Povratak** vraća korisnika na prvi zaslon.

Prvi zaslon koristi `StatefulWidget` i pri uklanjanju stanja oslobađa kontroler metodom `dispose()`. Drugi zaslon koristi `StatelessWidget` jer samo prikazuje proslijeđeno ime.

### 3. Brojač – `main_brojac.dart`

Primjer prikazuje zadanu Flutter aplikaciju s brojačem. Pritiskom na plutajući gumb **+** povećava se vrijednost brojača.

Brojač koristi `StatefulWidget`, varijablu `_counter` i metodu `setState()` za ažuriranje korisničkog sučelja.

**Hot Reload – demonstracija:**

1. Pokrenuti primjer naredbom `flutter run -t primjeri/main_brojac.dart`.
2. Nekoliko puta pritisnuti **+** (primjerice do vrijednosti 5).
3. Dok aplikacija radi u debug načinu, promijeniti tekst `Broj klikova na gumb:` u Dart datoteci i spremiti promjenu.
4. Izvesti Hot Reload (u terminalu pritisnuti `r` ako je Flutter pokrenut kroz `flutter run`).
5. Promijenjeni tekst prikazuje se bez resetiranja vrijednosti brojača.

**Hot Restart – demonstracija:** u istoj aktivnoj debug sesiji pritisnuti `R` u terminalu. Dart aplikacija ponovno se pokreće, a brojač se vraća na početnu vrijednost **0**.

**Debugging:** u VS Codeu postaviti breakpoint na redak `_counter++` u metodi `_incrementCounter()`, pokrenuti primjer u debug načinu i pritisnuti **+**. Izvršavanje će se zaustaviti na breakpointu, gdje je moguće pregledati stanje varijabli i nastaviti izvršavanje.

### 4. Glavna aplikacija i životni ciklus – `lib/main.dart`

Glavna aplikacija objedinjuje **unos imena, navigaciju između dva zaslona i praćenje životnog ciklusa**.

Životni ciklus aplikacije opisuje njezina stanja tijekom rada, primjerice kada je u prvom planu ili prelazi u pozadinu. 