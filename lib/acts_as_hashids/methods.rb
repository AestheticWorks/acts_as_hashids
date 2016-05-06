require_relative 'core'

module ActsAsHashids
  module Methods
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_hashids(options = {})
        include ActsAsHashids::Core unless ancestors.include?(ActsAsHashids::Core)

        define_singleton_method :hashids_secret do
          secret = options[:secret]
          (secret.respond_to?(:call) ? secret.call : secret) || base_class.name
        end

        define_singleton_method :hashids do
          length = options[:length] || 8
          Hashids.new(hashids_secret, length)
        end
      end
    end
  end
end