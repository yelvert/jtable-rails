module JTable
  module ActiveRecord
    extend ActiveSupport::Concern
    module ClassMethods
      def jtable(name, *fields)
        metaclass = class << self
          self
        end
        join_associations = []
        fields.each do |field|
          if field.kind_of? Hash
            field.each_pair do |assoc_name, assoc_fields|
              join_associations << assoc_name
              assoc_klass = assoc_name.to_s.camelcase.constantize
              assoc_fields.each do |assoc_field|
                metaclass.instance_eval do
                  define_method "jtable_#{name}_search_#{assoc_name}_#{assoc_field}" do |term|
                    unless [:date].include? assoc_klass.arel_table[assoc_field.to_sym].column.type
                      if [:integer, :boolean].include? assoc_klass.arel_table[assoc_field.to_sym].column.type
                        if term.to_i.to_s == term
                          assoc_klass.arel_table[assoc_field.to_sym].eq(term.to_i)
                        end
                      else
                        assoc_klass.arel_table[assoc_field.to_sym].matches("%#{term}%")
                      end
                    end
                  end
                  
                  define_method "jtable_#{name}_order_#{assoc_name}_#{assoc_field}" do |direction|
                    %Q["#{assoc_name.to_s.camelcase.constantize.table_name}".#{assoc_field} #{direction}]
                  end
                end
                
                define_method "jtable_#{name}_attribute_#{assoc_name}_#{assoc_field}" do
                  if assoc_klass.arel_table[assoc_field.to_sym].column.type == :date
                    self.send(assoc_name).send(assoc_field).strftime("%m/%d/%Y %I:%M%P")
                  else
                    self.send(assoc_name).send(assoc_field)
                  end
                end
              end
            end
          else
            metaclass.instance_eval do
              define_method "jtable_#{name}_search_#{field}" do |term|
                unless [:date].include? arel_table[field.to_sym].column.type
                  if [:integer, :boolean].include? arel_table[field.to_sym].column.type
                    if term.to_i.to_s == term
                      arel_table[field.to_sym].eq(term.to_i)
                    end
                  else
                    arel_table[field.to_sym].matches("%#{term}%")
                  end
                end
              end
            
              define_method "jtable_#{name}_order_#{field}" do |direction|
                "#{field} #{direction}"
              end
            end
            define_method "jtable_#{name}_attribute_#{field}" do
              if self.class.arel_table[field.to_sym].column.type == :date
                self.send(field).strftime("%m/%d/%Y %I:%M%P")
              else
                self.send(field)
              end
            end
          end
        end
        
        metaclass.instance_eval do
          define_method "jtable_#{name}_attributes" do
            fields
          end
        end
        
        define_method "jtable_#{name}_item" do
          item_hash = {}
          item_hash[:id] = self.id
          fields.each do |field|
            if field.kind_of? Hash
              field.each_pair do |assoc_name, assoc_fields|
                assoc_fields.each do |assoc_field|
                  item_hash["#{assoc_name}_#{assoc_field}".to_sym] = self.send("jtable_#{name}_attribute_#{assoc_name}_#{assoc_field}")
                end
              end
            else
              item_hash[field.to_sym] = self.send("jtable_#{name}_attribute_#{field}")
            end
          end
          item_hash
        end
        
        scope "jtable_#{name}_search", lambda { |jtable_params|
          search_terms = jtable_params[:search]
          unless search_terms.blank?
            wheres = []
            search_terms.split(" ").each do |term|
              where_query = []
              fields.each do |field|
                if field.kind_of? Hash
                  field.each_pair do |assoc_name, assoc_fields|
                    assoc_fields.each do |assoc_field|
                      next unless jtable_params[:searchable_columns].include?("#{assoc_name}_#{assoc_field}")
                      where_query << self.send("jtable_#{name}_search_#{assoc_name}_#{assoc_field}", term)
                    end
                  end
                else
                  next unless jtable_params[:searchable_columns].include?(field.to_s)
                  where_query << self.send("jtable_#{name}_search_#{field}", term)
                end
              end
              wheres << where(where_query.inject(&:or))
            end
            wheres.inject(&:merge)
          end
        }
        
        scope "jtable_#{name}_single_search", lambda {|column, search_terms|
          unless column.blank? or search_terms.blank?
            wheres = []
            search_terms.split(" ").each do |term|
              wheres << where(self.send("jtable_#{name}_search_#{column}", term))
            end
            wheres.inject(&:merge)
          end
        }
        
        scope "jtable_#{name}_order", lambda {|column, direction|
          if !column.blank? and !direction.blank? and %w(asc desc).include?(direction.downcase)
            order(self.send("jtable_#{name}_order_#{column}", direction))
          end
        }
        
        scope "jtable_#{name}_paginate", lambda {|per_page, page_start|
          limit(per_page.to_i).offset(page_start.to_i)
        }
        
        scope "jtable_#{name}_default", lambda {
          
        }
        
        scope "jtable_#{name}_query", lambda { |jtable_params|
          jtable_params = HashWithIndifferentAccess.new(jtable_params)
          queries = []
          unless join_associations.empty?
            join_associations.each do |join_association|
              queries << joins(join_association)
            end
          end
          queries << self.send("jtable_#{name}_default")
          queries << self.send("jtable_#{name}_search", jtable_params)
          unless jtable_params[:column_search].blank?
            jtable_params[:column_search].each_pair {|column, search|
              queries << self.send("jtable_#{name}_single_search", column, search)
            }
          end
          queries << self.send("jtable_#{name}_order", jtable_params[:sort_column], jtable_params[:sort_direction])
          queries.inject(&:merge)
        }
      end
    end
  end
end