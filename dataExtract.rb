def dir_size(from)
  dname = from
  sum = 0
  Dir.glob("#{dname}/**/*.html") do |fn|
    sum += File.stat(fn).size
  end
  sum / 1000
end
from = ARGV[0]
to = ARGV[1]
from = from.gsub(/\\/,'/')
to = to.gsub(/\\/,'/')
if File.directory?(from)
  if File.directory?(to)
    puts "directory exists."
    puts "estimating required time..."
    size = dir_size(from)
    printf("filesize: %d KB\n", size)
    printf("estimated time: %.1f minutes.\n", size / 100.0 )
    print ("extracting...")
    puts
    Dir.glob("#{from}/**/*.html") do |f|
      bn = File.basename(f)
      File.open(f, 'r:UTF-8') do |enc|
        $stdout.reopen("#{to}/#{bn}", 'w')
        puts enc.read.encode("Shift_JIS")
      end
    end
  else
    puts "cannot find #{to} directory."
  end
else
  puts "directory not exists."
end
