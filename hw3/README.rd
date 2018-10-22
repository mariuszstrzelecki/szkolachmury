3.1
Generalnie prawdopodobnie najlepiej byłoby użyć sugerowanych wzorców (https://docs.microsoft.com/pl-pl/azure/architecture/best-practices/naming-conventions) bo są one najbardziej powszechnie używane, a przez to zrozumiałe przez dużą liczbę profesjonalistów. Ale wiadomo, że wymagania biznesowe są różne i jeżeli mielibyśmy stworzyć coś "custom" to proponowałbym coś takiego:

<id środowiska lub Shrd dla współdzielonych przez kilka środowisk - 4 znaki><id aplikacji/systemu/roli lub Shrd dla współdzielonych - 2-4 znaki><zesłownikowany w ramach organizacji typ/id zasobu 2-4 znaków np. Vm, Vnet, Snet, odsk(dla OS), dsk1, dsk2><3 cyfrowy numer wystąpienia zasobu - w miarę możliwości tożsamy dla powiązanych zasobów np. VM, NIC, dyski, itp> - tam gdzie to jest możliwe używane "camelCase".

Przykłady:
- ProdCrmVm001
- ShrdWebNsg001
- tst1appxstor005
- Tst2ShrdRg001
- Tst3ShrdVnet001
- Tst3AppxSnet001

Dla zadań 3.4 i 3.4 użyto następujących nazw(<id środowiska> - CldS od Cloud School):

CldSShrdRg001
CldSShrdVnet001

CldSApp1Snet001
CldSApp2Snet001

CldSApp1Vm001
CldSApp2Vm001

CldSApp1Nic1001
CldSApp2Nic1001

CldSApp1Nsg001
CldSApp2Nsg001


3.2 
ARM Template znajduje się pod adresem: 

Przykładowy deployment można wykonać następująco:
- Zamienić wartości zmiennych w poniższym skrypcie na odpowiednie dla swojej subskrypcji i potrzeb.
- Wykonać dostosowaną sekwencję poleceń w Azure CLI(zostaniemy poproszeni o hasło administratora dla maszyn wirtualnych):
#ZMIENNE
#Opcjonalne do podmiany - wartości domyślne
ENV_ID=CldS
ENV_VNET_PREFIX=10.0
ENV_LOCATION=eastus

#Nie ruszać! Zmienne pomocnicze
RG="${ENV_ID}ShrdRg001"

#LOGIKA
az login
az group create --name $RG --location $ENV_LOCATION
az group deployment create --name "${ENV_ID}`date +%Y%m%d%H%M`" --resource-group $RG --template-uri https://raw.githubusercontent.com/mariuszstrzelecki/szkolachmury/master/hw3//3.2/all.json --parameters env_id=$ENV_ID vnet_prefix=$ENV_VNET_PREFIX 


3.3 
Przykładowa definicja roli znajduje się pod adresem: 

Przykładowy deployment można wykonać następująco:
- Pobrać plik JSON i podmienić id subskrypcji na włąsny (w repo ciąg: 00000000-0000-0000-0000-000000000000)
- Wykonać polecenia:

az login
az role definition create --role-definition doctor_restart_rbac.json

3.4
