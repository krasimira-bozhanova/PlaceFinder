libdir = File.expand_path(File.dirname(__FILE__))
puts libdir
$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))