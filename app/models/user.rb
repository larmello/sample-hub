class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :batch_receiver, foreign_key: 'receiver_id', class_name: 'Batch'
  has_many :batch_sender, foreign_key: 'sender_id', class_name: 'Batch'

  validates :first_name, :last_name, presence: true, format: { with: /\D+/ } # accepts any non-digit char
  validates :role, inclusion: { in: [
                                    'Envio de amostras',
                                    'Recepção de amostras'
                                    ], allow_nil: false }
  validates :cpf, uniqueness: true # CORRIGIR
  # Se role = Envio ou Recepção de amostra, exigir preenchimento de institution e matrícula ?
end
