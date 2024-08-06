# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `frozen_record` gem.
# Please instead update this file by running `bin/tapioca gem frozen_record`.


# source://frozen_record//lib/frozen_record/version.rb#3
module FrozenRecord
  class << self
    # Returns the value of attribute deprecated_yaml_erb_backend.
    #
    # source://frozen_record//lib/frozen_record/minimal.rb#17
    def deprecated_yaml_erb_backend; end

    # Sets the attribute deprecated_yaml_erb_backend
    #
    # @param value the value to set the attribute deprecated_yaml_erb_backend to.
    #
    # source://frozen_record//lib/frozen_record/minimal.rb#17
    def deprecated_yaml_erb_backend=(_arg0); end

    # source://frozen_record//lib/frozen_record/minimal.rb#19
    def eager_load!; end

    # Returns the value of attribute enforce_max_records_scan.
    #
    # source://frozen_record//lib/frozen_record/base.rb#10
    def enforce_max_records_scan; end

    # Sets the attribute enforce_max_records_scan
    #
    # @param value the value to set the attribute enforce_max_records_scan to.
    #
    # source://frozen_record//lib/frozen_record/base.rb#10
    def enforce_max_records_scan=(_arg0); end

    # source://frozen_record//lib/frozen_record/base.rb#12
    def ignore_max_records_scan; end
  end
end

# source://frozen_record//lib/frozen_record/backends.rb#4
module FrozenRecord::Backends; end

# source://frozen_record//lib/frozen_record/backends/json.rb#6
module FrozenRecord::Backends::Json
  extend ::FrozenRecord::Backends::Json

  # source://frozen_record//lib/frozen_record/backends/json.rb#9
  def filename(model_name); end

  # source://frozen_record//lib/frozen_record/backends/json.rb#21
  def load(file_path); end
end

# source://frozen_record//lib/frozen_record/backends/yaml.rb#5
module FrozenRecord::Backends::Yaml
  extend ::FrozenRecord::Backends::Yaml

  # Transforms the model name into a valid filename.
  #
  # @param format [String] the model name that inherits
  #   from FrozenRecord::Base
  # @return [String] the file name.
  #
  # source://frozen_record//lib/frozen_record/backends/yaml.rb#15
  def filename(model_name); end

  # Reads file in `file_path` and return records.
  #
  # @param format [String] the file path
  # @return [Array] an Array of Hash objects with keys being attributes.
  #
  # source://frozen_record//lib/frozen_record/backends/yaml.rb#23
  def load(file_path); end

  private

  # source://frozen_record//lib/frozen_record/backends/yaml.rb#58
  def load_file(path); end

  # source://frozen_record//lib/frozen_record/backends/yaml.rb#62
  def load_string(yaml); end
end

# source://frozen_record//lib/frozen_record/base.rb#22
class FrozenRecord::Base
  include ::ActiveModel::Conversion
  include ::ActiveModel::AttributeMethods
  include ::ActiveModel::Serialization
  include ::ActiveModel::Serializers::JSON
  extend ::ActiveSupport::DescendantsTracker
  extend ::ActiveModel::Naming
  extend ::ActiveModel::Conversion::ClassMethods
  extend ::ActiveModel::AttributeMethods::ClassMethods

  # @return [Base] a new instance of Base
  #
  # source://frozen_record//lib/frozen_record/base.rb#286
  def initialize(attrs = T.unsafe(nil)); end

  # source://frozen_record//lib/frozen_record/base.rb#303
  def ==(other); end

  # source://frozen_record//lib/frozen_record/base.rb#298
  def [](attr); end

  # source://frozen_record//lib/frozen_record/base.rb#298
  def attribute(attr); end

  # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#72
  def attribute_aliases; end

  # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#72
  def attribute_aliases?; end

  # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#73
  def attribute_method_patterns; end

  # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#73
  def attribute_method_patterns?; end

  # source://frozen_record//lib/frozen_record/base.rb#290
  def attributes; end

  # source://frozen_record//lib/frozen_record/base.rb#294
  def id; end

  # source://activemodel/7.1.3.2/lib/active_model/serializers/json.rb#15
  def include_root_in_json; end

  # source://activemodel/7.1.3.2/lib/active_model/serializers/json.rb#15
  def include_root_in_json?; end

  # source://activemodel/7.1.3.2/lib/active_model/naming.rb#255
  def model_name(&block); end

  # source://activemodel/7.1.3.2/lib/active_model/conversion.rb#32
  def param_delimiter=(_arg0); end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/base.rb#307
  def persisted?; end

  # source://frozen_record//lib/frozen_record/base.rb#311
  def to_key; end

  private

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/base.rb#317
  def attribute?(attribute_name); end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/base.rb#321
  def attribute_method?(attribute_name); end

  class << self
    # Returns the value of attribute abstract_class.
    #
    # source://frozen_record//lib/frozen_record/base.rb#90
    def abstract_class; end

    # Sets the attribute abstract_class
    #
    # @param value the value to set the attribute abstract_class to.
    #
    # source://frozen_record//lib/frozen_record/base.rb#90
    def abstract_class=(_arg0); end

    # @return [Boolean]
    #
    # source://frozen_record//lib/frozen_record/base.rb#99
    def abstract_class?; end

    # source://frozen_record//lib/frozen_record/base.rb#154
    def add_index(attribute, unique: T.unsafe(nil)); end

    # source://frozen_record//lib/frozen_record/base.rb#103
    def all; end

    # source://frozen_record//lib/frozen_record/base.rb#159
    def attribute(attribute, klass); end

    # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#72
    def attribute_aliases; end

    # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#72
    def attribute_aliases=(value); end

    # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#72
    def attribute_aliases?; end

    # source://frozen_record//lib/frozen_record/base.rb#33
    def attribute_deserializers; end

    # source://frozen_record//lib/frozen_record/base.rb#33
    def attribute_deserializers=(value); end

    # source://frozen_record//lib/frozen_record/base.rb#33
    def attribute_deserializers?; end

    # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#73
    def attribute_method_patterns; end

    # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#73
    def attribute_method_patterns=(value); end

    # source://activemodel/7.1.3.2/lib/active_model/attribute_methods.rb#73
    def attribute_method_patterns?; end

    # source://frozen_record//lib/frozen_record/base.rb#92
    def attributes; end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def auto_reloading; end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def auto_reloading=(value); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def auto_reloading?; end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def average(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def backend; end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def backend=(value); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def backend?; end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def base_path; end

    # source://frozen_record//lib/frozen_record/base.rb#85
    def base_path=(base_path); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def base_path?; end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def count(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#103
    def current_scope; end

    # source://frozen_record//lib/frozen_record/base.rb#108
    def current_scope=(scope); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def default_attributes; end

    # source://frozen_record//lib/frozen_record/base.rb#73
    def default_attributes=(default_attributes); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def default_attributes?; end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def each(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#185
    def eager_load!; end

    # @raise [ArgumentError]
    #
    # source://frozen_record//lib/frozen_record/base.rb#116
    def file_path; end

    # @raise [RecordNotFound]
    #
    # source://frozen_record//lib/frozen_record/base.rb#132
    def find(id); end

    # source://frozen_record//lib/frozen_record/base.rb#137
    def find_by(criterias); end

    # source://frozen_record//lib/frozen_record/base.rb#150
    def find_by!(criterias); end

    # source://frozen_record//lib/frozen_record/base.rb#128
    def find_by_id(id); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def find_each(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def first(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def first!(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def ids(*_arg0, **_arg1, &_arg2); end

    # source://activemodel/7.1.3.2/lib/active_model/serializers/json.rb#15
    def include_root_in_json; end

    # source://activemodel/7.1.3.2/lib/active_model/serializers/json.rb#15
    def include_root_in_json=(value); end

    # source://activemodel/7.1.3.2/lib/active_model/serializers/json.rb#15
    def include_root_in_json?; end

    # source://frozen_record//lib/frozen_record/base.rb#32
    def index_definitions; end

    # source://frozen_record//lib/frozen_record/base.rb#32
    def index_definitions=(value); end

    # source://frozen_record//lib/frozen_record/base.rb#32
    def index_definitions?; end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def last(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def last!(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def limit(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#197
    def load_records(force: T.unsafe(nil)); end

    # source://frozen_record//lib/frozen_record/base.rb#34
    def max_records_scan; end

    # source://frozen_record//lib/frozen_record/base.rb#34
    def max_records_scan=(value); end

    # source://frozen_record//lib/frozen_record/base.rb#34
    def max_records_scan?; end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def maximum(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#163
    def memsize(object = T.unsafe(nil), seen = T.unsafe(nil)); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def minimum(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#222
    def new(attrs = T.unsafe(nil)); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def offset(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def order(*_arg0, **_arg1, &_arg2); end

    # source://activemodel/7.1.3.2/lib/active_model/conversion.rb#32
    def param_delimiter; end

    # source://activemodel/7.1.3.2/lib/active_model/conversion.rb#32
    def param_delimiter=(value); end

    # source://activemodel/7.1.3.2/lib/active_model/conversion.rb#32
    def param_delimiter?; end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def pluck(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def primary_key; end

    # source://frozen_record//lib/frozen_record/base.rb#79
    def primary_key=(primary_key); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def primary_key?; end

    # @return [Boolean]
    #
    # source://frozen_record//lib/frozen_record/base.rb#178
    def respond_to_missing?(name, *_arg1); end

    # source://frozen_record//lib/frozen_record/base.rb#215
    def scope(name, body); end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def sum(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#191
    def unload!; end

    # source://frozen_record//lib/frozen_record/base.rb#112
    def where(*_arg0, **_arg1, &_arg2); end

    # source://frozen_record//lib/frozen_record/base.rb#63
    def with_max_records_scan(value); end

    private

    # source://frozen_record//lib/frozen_record/base.rb#238
    def assign_defaults!(record); end

    # source://frozen_record//lib/frozen_record/base.rb#250
    def deserialize_attributes!(record); end

    # source://frozen_record//lib/frozen_record/base.rb#269
    def dynamic_match(expression, values, bang); end

    # @return [Boolean]
    #
    # source://frozen_record//lib/frozen_record/base.rb#228
    def file_changed?; end

    # source://frozen_record//lib/frozen_record/base.rb#274
    def list_attributes(records); end

    def load(*_arg0); end

    # source://frozen_record//lib/frozen_record/base.rb#262
    def method_missing(name, *args); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def set_base_path(value); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def set_default_attributes(value); end

    # source://frozen_record//lib/frozen_record/base.rb#31
    def set_primary_key(value); end

    # source://frozen_record//lib/frozen_record/base.rb#234
    def store; end
  end
end

# source://frozen_record//lib/frozen_record/base.rb#29
FrozenRecord::Base::FALSY_VALUES = T.let(T.unsafe(nil), Set)

# source://frozen_record//lib/frozen_record/base.rb#28
FrozenRecord::Base::FIND_BY_PATTERN = T.let(T.unsafe(nil), Regexp)

# source://frozen_record//lib/frozen_record/base.rb#44
class FrozenRecord::Base::ThreadSafeStorage
  # @return [ThreadSafeStorage] a new instance of ThreadSafeStorage
  #
  # source://frozen_record//lib/frozen_record/base.rb#46
  def initialize(key); end

  # source://frozen_record//lib/frozen_record/base.rb#50
  def [](key); end

  # source://frozen_record//lib/frozen_record/base.rb#55
  def []=(key, value); end
end

# source://frozen_record//lib/frozen_record/compact.rb#4
module FrozenRecord::Compact
  extend ::ActiveSupport::Concern

  mixes_in_class_methods ::FrozenRecord::Compact::ClassMethods

  # source://frozen_record//lib/frozen_record/compact.rb#45
  def initialize(attrs = T.unsafe(nil)); end

  # source://frozen_record//lib/frozen_record/compact.rb#55
  def [](attr); end

  # source://frozen_record//lib/frozen_record/compact.rb#49
  def attributes; end

  private

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/compact.rb#69
  def attribute?(attribute_name); end

  # source://frozen_record//lib/frozen_record/compact.rb#63
  def attributes=(attributes); end
end

# source://frozen_record//lib/frozen_record/compact.rb#7
module FrozenRecord::Compact::ClassMethods
  # Returns the value of attribute _attributes_cache.
  #
  # source://frozen_record//lib/frozen_record/compact.rb#32
  def _attributes_cache; end

  # source://frozen_record//lib/frozen_record/compact.rb#28
  def define_method_attribute(attr, **_arg1); end

  # source://frozen_record//lib/frozen_record/compact.rb#8
  def load_records(force: T.unsafe(nil)); end

  private

  # source://frozen_record//lib/frozen_record/compact.rb#36
  def build_attributes_cache; end
end

# source://frozen_record//lib/frozen_record/index.rb#4
class FrozenRecord::Index
  # @return [Index] a new instance of Index
  #
  # source://frozen_record//lib/frozen_record/index.rb#12
  def initialize(model, attribute, unique: T.unsafe(nil)); end

  # Returns the value of attribute attribute.
  #
  # source://frozen_record//lib/frozen_record/index.rb#10
  def attribute; end

  # source://frozen_record//lib/frozen_record/index.rb#42
  def build(records); end

  # source://frozen_record//lib/frozen_record/index.rb#34
  def lookup(value); end

  # source://frozen_record//lib/frozen_record/index.rb#30
  def lookup_multi(values); end

  # Returns the value of attribute model.
  #
  # source://frozen_record//lib/frozen_record/index.rb#10
  def model; end

  # source://frozen_record//lib/frozen_record/index.rb#22
  def query(matcher); end

  # source://frozen_record//lib/frozen_record/index.rb#38
  def reset; end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/index.rb#18
  def unique?; end
end

# source://frozen_record//lib/frozen_record/index.rb#8
class FrozenRecord::Index::AttributeNonUnique < ::StandardError; end

# source://frozen_record//lib/frozen_record/index.rb#5
FrozenRecord::Index::EMPTY_ARRAY = T.let(T.unsafe(nil), Array)

# source://frozen_record//lib/frozen_record/railtie.rb#4
class FrozenRecord::Railtie < ::Rails::Railtie; end

# source://frozen_record//lib/frozen_record/minimal.rb#14
class FrozenRecord::RecordNotFound < ::StandardError; end

# source://frozen_record//lib/frozen_record/scope.rb#4
class FrozenRecord::Scope
  # @return [Scope] a new instance of Scope
  #
  # source://frozen_record//lib/frozen_record/scope.rb#27
  def initialize(klass); end

  # source://frozen_record//lib/frozen_record/scope.rb#137
  def ==(other); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def all?(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def as_json(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#89
  def average(attribute); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def collect(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def count(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def each(*_arg0, **_arg1, &_arg2); end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#101
  def exists?; end

  # @raise [RecordNotFound]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#40
  def find(id); end

  # source://frozen_record//lib/frozen_record/scope.rb#50
  def find_by(criterias); end

  # source://frozen_record//lib/frozen_record/scope.rb#54
  def find_by!(criterias); end

  # source://frozen_record//lib/frozen_record/scope.rb#36
  def find_by_id(id); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def find_each(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def first(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#58
  def first!; end

  # source://frozen_record//lib/frozen_record/scope.rb#133
  def hash; end

  # source://frozen_record//lib/frozen_record/scope.rb#81
  def ids; end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def include?(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def last(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#62
  def last!; end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def length(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#121
  def limit(amount); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def map(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#97
  def maximum(attribute); end

  # source://frozen_record//lib/frozen_record/scope.rb#93
  def minimum(attribute); end

  # source://frozen_record//lib/frozen_record/scope.rb#125
  def offset(amount); end

  # source://frozen_record//lib/frozen_record/scope.rb#117
  def order(*ordering); end

  # source://frozen_record//lib/frozen_record/scope.rb#70
  def pluck(*attributes); end

  # source://frozen_record//lib/frozen_record/scope.rb#85
  def sum(attribute); end

  # source://frozen_record//lib/frozen_record/scope.rb#66
  def to_a; end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def to_ary(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#11
  def to_json(*_arg0, **_arg1, &_arg2); end

  # source://frozen_record//lib/frozen_record/scope.rb#105
  def where(criterias = T.unsafe(nil)); end

  # source://frozen_record//lib/frozen_record/scope.rb#113
  def where_not(criterias); end

  protected

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#257
  def array_delegable?(method); end

  # source://frozen_record//lib/frozen_record/scope.rb#166
  def clear_cache!; end

  # source://frozen_record//lib/frozen_record/scope.rb#144
  def comparable_attributes; end

  # source://frozen_record//lib/frozen_record/scope.rb#236
  def compare(record_a, record_b); end

  # source://frozen_record//lib/frozen_record/scope.rb#278
  def limit!(amount); end

  # source://frozen_record//lib/frozen_record/scope.rb#177
  def matching_records; end

  # source://frozen_record//lib/frozen_record/scope.rb#246
  def method_missing(method_name, *args, **_arg2, &block); end

  # source://frozen_record//lib/frozen_record/scope.rb#283
  def offset!(amount); end

  # source://frozen_record//lib/frozen_record/scope.rb#271
  def order!(*ordering); end

  # source://frozen_record//lib/frozen_record/scope.rb#173
  def query_results; end

  # source://frozen_record//lib/frozen_record/scope.rb#155
  def scoping; end

  # source://frozen_record//lib/frozen_record/scope.rb#183
  def select_records(records); end

  # source://frozen_record//lib/frozen_record/scope.rb#228
  def slice_records(records); end

  # source://frozen_record//lib/frozen_record/scope.rb#220
  def sort_records(records); end

  # source://frozen_record//lib/frozen_record/scope.rb#162
  def spawn; end

  # source://frozen_record//lib/frozen_record/scope.rb#261
  def where!(criterias); end

  # source://frozen_record//lib/frozen_record/scope.rb#266
  def where_not!(criterias); end

  private

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#129
  def respond_to_missing?(method_name, *_arg1); end
end

# source://frozen_record//lib/frozen_record/scope.rb#181
FrozenRecord::Scope::ARRAY_INTERSECTION = T.let(T.unsafe(nil), TrueClass)

# source://frozen_record//lib/frozen_record/scope.rb#338
class FrozenRecord::Scope::CoverMatcher < ::FrozenRecord::Scope::Matcher
  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#343
  def match?(other); end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#339
  def ranged?; end
end

# source://frozen_record//lib/frozen_record/scope.rb#5
FrozenRecord::Scope::DISALLOWED_ARRAY_METHODS = T.let(T.unsafe(nil), Set)

# source://frozen_record//lib/frozen_record/scope.rb#328
class FrozenRecord::Scope::IncludeMatcher < ::FrozenRecord::Scope::Matcher
  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#333
  def match?(other); end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#329
  def ranged?; end
end

# source://frozen_record//lib/frozen_record/scope.rb#290
class FrozenRecord::Scope::Matcher
  # @return [Matcher] a new instance of Matcher
  #
  # source://frozen_record//lib/frozen_record/scope.rb#310
  def initialize(value); end

  # source://frozen_record//lib/frozen_record/scope.rb#322
  def ==(other); end

  # source://frozen_record//lib/frozen_record/scope.rb#322
  def eql?(other); end

  # source://frozen_record//lib/frozen_record/scope.rb#306
  def hash; end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#318
  def match?(other); end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/scope.rb#314
  def ranged?; end

  # Returns the value of attribute value.
  #
  # source://frozen_record//lib/frozen_record/scope.rb#304
  def value; end

  class << self
    # source://frozen_record//lib/frozen_record/scope.rb#292
    def for(value); end
  end
end

# source://frozen_record//lib/frozen_record/scope.rb#17
class FrozenRecord::Scope::WhereChain
  # @return [WhereChain] a new instance of WhereChain
  #
  # source://frozen_record//lib/frozen_record/scope.rb#18
  def initialize(scope); end

  # source://frozen_record//lib/frozen_record/scope.rb#22
  def not(criterias); end
end

# source://frozen_record//lib/frozen_record/base.rb#7
class FrozenRecord::SlowQuery < ::StandardError; end

# source://frozen_record//lib/frozen_record/index.rb#52
class FrozenRecord::UniqueIndex < ::FrozenRecord::Index
  # source://frozen_record//lib/frozen_record/index.rb#68
  def build(records); end

  # source://frozen_record//lib/frozen_record/index.rb#63
  def lookup(value); end

  # source://frozen_record//lib/frozen_record/index.rb#57
  def lookup_multi(values); end

  # @return [Boolean]
  #
  # source://frozen_record//lib/frozen_record/index.rb#53
  def unique?; end
end

# source://frozen_record//lib/frozen_record/version.rb#4
FrozenRecord::VERSION = T.let(T.unsafe(nil), String)
