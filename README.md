
# Termhub WWW Files
These are web files to be served through top level terminologyhub.com domains.

### Installing

    make install

### Termhub Examples Files

We can build static termhub pages for viewing and share to here for exchange. 

First save the relevant static pages from the browser directly and put into termhub-examples.zip

```
zip -r termhub-examples.zip Termhub*
aws s3 cp termhub-examples.zip s3://termhub-data-shared/examples/termhub-examples-icd10cm.zip
aws s3 cp termhub-examples.zip s3://termhub-data-shared/examples/termhub-examples.zip
```

Then log into dev.terminologyhub.com to host them

```
cd /var/www/html/examples
aws s3 cp s3://termhub-data-shared/examples/termhub-examples.zip .
echo "A" | unzip termhub-examples.zip
chmod -R uga+rw *
chmod -R uga+x *files
```

The following is for ICD10CM examples:

```
for f in E11.9 F10.20 F32.9 I10 J45.909 O26.841 O80 Q21.1 Q90.9 R07.9 R51.9 S06.0X0A S72.001A V43.52XA W20.8XXA Z00.00 Z79.01; do
 ls *$f*html
perl -pe '
  $x=qq{w-100 d-flex justify-content-end">.*Sign Out</div></div></div>};
  $y= qq{w-100 d-flex justify-content-end"><div><b><a href="https://app.terminologyhub.com/signup">Signup for TermHub</a></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>};
  s/$x/$y/;
  s/$x//;' *$f*html > x.html
  /bin/mv -f x.html *$f*.html
done

echo "<html><head><title>Examples</title></head><body><ul>" > index.html
ls *ICD10CM*html | perl -ne 'chop; @_=split/_/; print qq{<li><a href="$_">$_[2]</a></li>\n};' >> index.html
echo "</ul></body></html>" >> index.html

```

The following is for SNOMEDCT examples:

```
echo "A" | unzip termhub-examples-snomedct.zip
chmod -R uga+rw *
chmod -R uga+x *files

for f in 10200004 14106009 165397008 22298006 232717009 24184005 26604007 29857009 303728004 36048009 372687004 376701008 386661006 73211009 80146002 80891009; do
 ls *$f*html
perl -pe '
  $x=qq{w-100 d-flex justify-content-end">.*Sign Out</div></div></div>};
  $y= qq{w-100 d-flex justify-content-end"><div><b><a href="https://app.terminologyhub.com/signup">Signup for TermHub</a></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>};
  s/$x/$y/;
  s/$x//;' *$f*html > x.html
  /bin/mv -f x.html *$f*.html
done
```
