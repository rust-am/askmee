class Question < ApplicationRecord

  belongs_to :user

  validates :text, :user, presence: true
  validates :text, length: { maximum: 255,
                             message: "Question text maximum length is 255 characters."}

#   before_validation :before_validation
#   after_validation :after_validation
#
#   before_save :before_save
#   after_save :after_save
#
#   before_create :before_create
#   after_create :after_create
#
#   before_update :before_update
#   after_update :after_update
#
#   before_destroy :before_destroy
#   after_destroy :after_destroy
#
#   private
#
#   # Динамически сгенерируем пару методов для каждого действия, используя
#   # возможности руби (этот код нужен только для демонстрации валидаций и потом
#   # мы его удалим).
#   %w(validation save create update destroy).each do |action|
#     %w(before after).each do |time|
#       define_method("#{time}_#{action}") do
#         puts "8******> #{time} #{action}"
#       end
#     end
#   end
end
