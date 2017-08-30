Pod::Spec.new do |s|
  s.name         = "CDZPicker"
  s.version      = "1.1.0"
  s.summary      = "A easy picker view with linkage"
  s.homepage     = "https://github.com/Nemocdz/CDZPicker"
  s.license      = "MIT"
  s.authors      = { 'Nemocdz' => 'nemocdz@gmail.com'}
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Nemocdz/CDZPicker.git", :tag => s.version }
  s.source_files = 'CDZPickerView', 'CDZPickerViewDemo/CDZPicker/*.{h,m}'
  s.requires_arc = true
end
