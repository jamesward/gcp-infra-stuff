# Google Cloud Storage

## Tips and Trips

* Give someone access to your bucket
```
gsutil iam ch user:ae@g.com:objectCreator,objectViewer gs://bucket
```

* To remove this permission
```
gsutil iam ch -d user:ae@g.com:objectCreator,objectViewer gs://bucket
```

* Create public link 
```
gsutil acl ch -u AllUsers:R gs://bucket/kitten.png
```
* Make object private 
```
gsutil acl ch -d AllUsers gs://bucket/kitten.png 
```
or 
```
gsutil acl set private gs://$BUCKET_NAME/setup.html 
```

* Get an ACL file 
```
gsutil acl get gs://bucket/paris.jpg
```
* Copy large files fast
```
gsutil -m -o GSUtil:parallel_composite_upload_threshold=150M cp ./localbigfile gs://your-bucket
```
* Copy large files faster (Maximize speed of transfer between a VM and an object
```
gsutil -o 'GSUtil:parallel_thread_count=1' -o 'GSUtil:sliced_object_download_max_components=8' \
cp gs://something/file.1tb .
```
