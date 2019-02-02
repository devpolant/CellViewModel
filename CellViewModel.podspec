Pod::Spec.new do |s|

  s.name         = "CellViewModel"

  s.version      = "0.1.0"

  s.summary      = "CellViewModel is a protocol that includes logic for reuse, accessibility and dequeue"

  s.description  = "Repository contains CellViewModel implementation
                    that includes logic for reuse, accessibility and dequeue"

  s.homepage     = "https://github.com/AntonPoltoratskyi/CellViewModel"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author    = "Anton Poltoratskyi"

  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/AntonPoltoratskyi/CellViewModel.git", :tag => "#{s.version}" }

  s.source_files  = "CellViewModel/Sources", "CellViewModel/Sources/**/*.{swift}"

  s.framework  = "UIKit"

  s.swift_version = "4.2"

end
