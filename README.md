# Home'Bank Small Data
## ELK Stack appliance on Vagrant with Docker for visualizing your ING Home'Bank transactions

Because spreadsheets are so Y2K and we've got better tools now this is an ELK (Elasticsearch, Logstash, Kibana) appliance that runs on Vagrant with Docker and it gives you instant insight into your ING Home'Bank account statements.

Shout out to [Sébastien Pujadas](http://pujadas.net/) for his excellent elk Docker image that just works awesomely!

The appliance has a nifty bash script to hammer the not so CSVish format that Home'Bank spits out into proper CSV. Everything is in the .sh file and I'd rather not explain what it does. Rest assured it does not initiate any financial transactions on your behalf ;-)

**Warning:** This is tested on my Romanian Home'Bank account data and I had to substitute all , for . to get rid of the local numeric notation and because of that notation most of the fields were quoted anyway. Because of the above said bash script regexes to use it for another language you will likely have to identify the same patterns in the account statement files in your language and fix the bash script yourself.

### Usage

First you need to donwload your account statements and put them all in the data folder. The CSV files exported from Home'Bank are named like Extras_de_cont_2013_decembrie_RON.csv.

You just need to have Vagrant and VirtualBox installed and run `vagrant up` in the root folder.

It is possible that you get some Kibana timeouts if you try to access data right away. I would give the appliance about 3-5 minutes time before trying to use the Kibana UI. Once you can access Kibana at [http://127.0.0.1:5601/](http://127.0.0.1:5601/) you will need to configure your index patter by putting `homebank-*` in the Index name field and clicking Create.

Then the quickest way to see something cool is to go to Visualize > Vertical Bar Chart > From a new search > Y Axis / Aggregation Sum / Field amount > Select bucket X Axis / Aggregation Date Histogram / Interval Monthly > Click on the Apply changes arrow right to Data / Options. Make sure you set the time span at the top right to "Last 5 years". If you change to "Interval Daily" and paste `Merchant:"omv" OR Merchant:"petro" OR Merchant:"mol" OR Merchant:"luk"` into the search bar you will get to see a graph of your monthly trips to the gas station.

The CSV has the following fields that are available in Kibana for querying: Type (Purchase, Transfer or Withdrawal), Amount, Card and Merchant. The Merchant field contains everything in the transaction details like merchant name, address and other gibberish.

Other stuff you'll have to figure out by yourself but the most useful would be to play with the search patterns that Kibana queries offer. You can start [here](https://www.elastic.co/guide/en/kibana/3.0/queries.html). A good basic tutorial would be this one [http://blog.webkid.io/visualize-datasets-with-elk/](http://blog.webkid.io/visualize-datasets-with-elk/).
ome'Bank only allows downloading statements for the last 2 years but I can imagine the graphs would look way cooler with more data.

Tested on OSX El Capitan with Vagrant 1.7.4.

Enjoy!

### Description in Romanian

Aplicatie ELK Stack rulata pe Vagrant cu Docker pentru vizualizarea tranzactiilor din ING Home'Bank. Permite vizualizarea in Kibana a tranzactiilor financiare inregistrate prin ING Home'Bank si inlocuieste cu success aplicatiile de tip Excel. Functionalitatile de cautare oferite de Elasticsearch perit crearea de vizualizari avansate in Kibana. Pentru mai multe detalii vedeti descrierea in engleza.


