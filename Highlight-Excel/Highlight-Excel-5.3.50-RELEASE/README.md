# Highlight Excel

## Export data from Highlight Portal
Export data from Highlight Portal
```bash
java -jar Highlight-Excel-{version} export --host={host} --login={login} --password={password} --file={destination file}
```

| Mandatory | Parameter                              | Description                       |
| ---       | ---                                    | ---                               |
| yes       | --host=https://localhost/WS2/domains/4 | Rest api url to root domain       | 
| yes       | --login=login                          | Your login to Highlight Portal    |
| yes       | --password=password                    | Your password to Highlight Portal |
| yes       | --file=Highlight-Excel.xlsx            | Destination file                  |

## Import data to Highlight Portal
Import data to Highlight Portal
```bash
java -jar Highlight-Excel-{version} import --host={host} --login={login} --password={password} --file={destination file}
```

| Mandatory | Parameter                              | Description                       |
| ---       | ---                                    | ---                               |
| yes       | --host=https://localhost/WS2/domains/4 | Rest api url to root domain       | 
| yes       | --login=login                          | Your login to Highlight Portal    |
| yes       | --password=password                    | Your password to Highlight Portal |
| yes       | --file=Highlight-Excel.xlsx            | Reading file                      |


## Proxy configuration
To configure a proxy server you can set JAVA properties


| Mandatory | Parameter                              | Description                       |
| ---       | ---                                    | ---                               |
| yes       | -Dhttps.proxyHost=192.168.1.2          | Host name of the proxy server     | 
| yes       | -Dhttps.proxyPort=80                   | Port of the proxy server          |
| false     | -Dhttps.proxyUser=user                 | User                              |
| false     | -Dhttps.proxyPassword=password         | User password                     |

```bash
java -Dhttps.proxyHost={host} -Dhttps.proxyPort={port} -Dhttps.proxyUser={user} -Dhttps.proxyPassword={password} -jar Highlight-Excel-{version} export --host={host} --login={login} --password={password} --file={destination file}
```

```bash
java -Dhttps.proxyHost={host} -Dhttps.proxyPort={port} -Dhttps.proxyUser={user} -Dhttps.proxyPassword={password} -jar Highlight-Excel-{version} import --host={host} --login={login} --password={password} --file={destination file}
```