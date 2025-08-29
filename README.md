
# Termhub WWW Files
These are web files to be served through top level terminologyhub.com domains.

### Installing

    make install

### Termhub Examples Files

We can build static termhub pages for viewing and share to here for exchange. 

First go to "prod" termhub and log in.  Generally use the public projects for examples unless content is not available.

Find the browser view you want and "save" the page (in Chrome) as "Web page, complete".  This saves an .html file and a directory with the same name for each page you save.

Then you need to zip up all of the files that you just saved into a .zip file
(be aware that if you've done this previously, you may have older files in your
downloads folder and need to make adjustments)

For example,

```
zip -r termhub-examples.zip Termhub*
aws s3 cp termhub-examples.zip s3://termhub-data-shared/examples/termhub-examples.zip
```

#### Then log into dev.terminologyhub.com to host them

Start by going to the directory where the pages live, pulling down the .zip
generated above, and then steting permissions.

```
cd /var/www/html/examples
aws s3 cp s3://termhub-data-shared/examples/termhub-examples.zip .
echo "A" | unzip termhub-examples.zip
chmod -R uga+rw *
chmod -R uga+x *files
```

#### Clean up the files to say "Signin to termhub":

For each code that we are deploying files for, list in the "for f ..."

```
for f in 10839-9 2085-9 2160-0 2345-7 4548-4 72166-2 72253-8 8310-5 89263-8 94016-3; do
 ls *$f*html
 perl -pe '
  $x=qq{d-flex align-items-center justify-content-end">.*?Sign Out.*?</div></nav>};
  $y= qq{d-flex align-items-center justify-content-end"><div><b><a href="https://app.terminologyhub.com/signup">Signup for TermHub</a></b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div></div></nav>};
  s/$x/$y/;
  ' *$f*html > x.html
  /bin/mv -f x.html *$f*.html
done
```

To see each file, use https://dev.terminologyhub.com/examples/<filename>


### Make the index page

```
echo "<html><head><title>Examples</title></head><body><ul>" > index.html
ls *html | perl -ne 'chop; @_=split/_/; print qq{<li><a href="$_">$_[2]</a></li>\n};' >> index.html
echo "</ul></body></html>" >> index.html
```

See https://dev.terminologyhub.com/examples/index.html

