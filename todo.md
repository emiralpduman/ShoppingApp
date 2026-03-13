# Test & CI Todo

## Tamamlanan
- [x] XCTest framework ile unit test yazımı (49 test, hepsi geçiyor)
- [x] Accessibility identifier'lar tüm View dosyalarına eklendi (41 identifier)
- [x] ViewModel unit testleri (Cart, Products, Launch, Auth)
- [x] Test coverage badge'i README'ye eklendi (Codecov)
- [x] Build status badge'i güncellendi — CI'da testler çalışıyor
- [x] Kritik kullanıcı akışları için UI testleri (14 test: Auth, Products, Cart, Profile)
- [x] CI workflow'a Codecov coverage upload entegrasyonu (codecov-action@v5, app+api flag'leri)

## Yapılacak
- [ ] CI pipeline debug — fail eden adımları tespit et ve düzelt
- [ ] %60+ coverage hedefi, ideal %70+ (UI testleri ve unit testler ile hedefe ulaşılacak)
- [ ] GitHub repo'ya CODECOV_TOKEN secret eklenmesi (Settings → Secrets → Actions)
