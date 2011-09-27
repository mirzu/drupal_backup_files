: ${1?"Usage: $0 instance_short_name"}
bucket="<bucket-name>"
date=`date +%Y-%m-%d_%s`
instance=$1
filename=sdge.$instance.files.$date
logger -t backup_to_s3.sh "Backing up $instance files to S3"
cd /var/www/$instance/sites/default
tar -cf $filename.tar files
bzip2 -9 $filename.tar
s3cmd put $filename.tar.bz2 ${bucket}
rm /var/www/$instance/sites/default/$filename.tar.bz2