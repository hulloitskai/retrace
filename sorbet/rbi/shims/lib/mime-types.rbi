# typed: strong

module MIME
  class Types
    sig { params(filename: String).returns(T::Array[Type]) }
    def self.of(filename); end
  end
end
