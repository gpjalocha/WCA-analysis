if('Ranks'%in%ls()){}else{source('download.R')}

for(a in dir(pattern='tsv')){
  assign(gsub('.tsv|WCA_export_','',a),fread( a,encoding = 'UTF-8'))
}