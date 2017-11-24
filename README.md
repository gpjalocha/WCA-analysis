# rubiks_etl

In this branch I will upload some of my analysis and WCA statistics requests in separate .R scripts. Scrpit 'load data.R' You can use for your own analysis loads the WCA data into R workspace('download.R' downloads up-to-date WCA database in separate tsv files into working directory)

```r
for(a in dir(pattern='tsv')){
  assign(gsub('.tsv|WCA_export_','',a),fread( a,encoding = 'UTF-8'))
}
```
