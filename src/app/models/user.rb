# frozen_string_literal: true

# Represents a user of the web application
class User < ApplicationRecord
  # Devise is a premade system for managing logins
  # You don't need to do login yourself. It's done for you.
  # TCNJ: don't edit the login system.

  enum role: {
    user: 0,
    admin: 1
  }

  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :projects
end
