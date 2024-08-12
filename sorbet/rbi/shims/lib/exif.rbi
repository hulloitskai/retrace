# typed: strong

module Exif
  class Data
    sig { params(data: T.untyped).returns(Data) }
    def self.new(data); end
  end
end
