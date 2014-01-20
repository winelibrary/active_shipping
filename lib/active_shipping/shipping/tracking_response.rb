module ActiveMerchant #:nodoc:
  module Shipping
    
    class TrackingResponse < Response
      attr_reader :carrier # symbol
      attr_reader :carrier_name # string
      attr_reader :status # symbol
      attr_reader :status_code # string
      attr_reader :status_code_detail # string
      attr_reader :status_description #string
      attr_reader :ship_time # time
      attr_reader :scheduled_delivery_date # time
      attr_reader :actual_delivery_date # time
      attr_reader :delivery_signature #string
      attr_reader :tracking_number # string
      attr_reader :shipment_events # array of ShipmentEvents in chronological order
      attr_reader :shipper_address, :origin, :destination # Location objects
      
      def initialize(success, message, params = {}, options = {})
        @carrier = options[:carrier].parameterize.to_sym
        @carrier_name = options[:carrier]
        @status = options[:status]
        @status_code = options[:status_code]
        @status_code_detail = options[:status_code_detail]
        @status_description = options[:status_description]
        @ship_time = options[:ship_time]
        @scheduled_delivery_date = options[:scheduled_delivery_date]
        @actual_delivery_date = options[:actual_delivery_date]
        @delivery_signature = options[:delivery_signature]
        @tracking_number = options[:tracking_number]
        @shipment_events = Array(options[:shipment_events])
        @shipper_address = options[:shipper_address]
        @origin = options[:origin]
        @destination = options[:destination]
        super
      end

      def latest_event
        @shipment_events.last
      end

      def is_delivered?
        @status == :delivered
      end

      def has_exception?
        @status == :exception
      end

      alias_method(:exception_event, :latest_event)
      alias_method(:delivered?, :is_delivered?)
      alias_method(:exception?, :has_exception?)
      alias_method(:scheduled_delivery_time, :scheduled_delivery_date)
      alias_method(:actual_delivery_time, :actual_delivery_date)
    end
    
  end
end
