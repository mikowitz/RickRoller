#
# rb_main.rb
# RickRoller
#
# Created by Michael Berkowitz on 4/15/10.
# Copyright SmartLogic Solutions 2010. All rights reserved.
#

# Loading the Cocoa framework. If you need to load more frameworks, you can
# do that here too.
framework 'Cocoa'

# Loading all the Ruby project files.
main = File.basename(__FILE__, File.extname(__FILE__))
dir_path = NSBundle.mainBundle.resourcePath.fileSystemRepresentation
Dir.glob(File.join(dir_path, '*.{rb,rbo}')).map { |x| File.basename(x, File.extname(x)) }.uniq.each do |path|
  if path != main and path !~ /_spec/
    p path
    require(path)
  end
end

# Starting the Cocoa main loop.
NSApplicationMain(0, nil)
