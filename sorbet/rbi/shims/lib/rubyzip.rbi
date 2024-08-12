# typed: strong

module Zip
  class File
    Elem = type_member { { fixed: Entry } }

    sig { params(block: T.proc.params(entry: Entry).void).void }
    def each(&block); end

    sig do
      type_parameters(:U).params(
        file_name: T.untyped,
        create: T.nilable(T::Boolean),
        options: T.untyped,
        block: T.proc.params(file: File).returns(T.type_parameter(:U)),
      ).returns(T.type_parameter(:U))
    end
    def self.open(
      file_name,
      create = T.unsafe(nil),
      options = T.unsafe(nil),
      &block
    ); end
  end
end
