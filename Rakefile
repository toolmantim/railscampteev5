desc "Compile on da fly"
task :default do
  Thread.new { `coffee -w -c -o public views/v5.coffee` }
  Thread.new { `sass --watch views/v5.scss:public/v5.css --scss --load-path views --style compressed --no-cache` }.join
end
