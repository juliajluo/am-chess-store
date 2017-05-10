class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.role? :admin
      can :manage, :all

    elsif user.role? :manager
      #1.can read any info in the system
      can :read, :all

      #2. can create edit and read employee data
      can :create, User, User.employees
      can :edit, User, User.employees
      can :read, User, User.employees

      #3. can create, edit, and read
      #power to destroy and deactivate and upload images CHECK
      can :create, Item
      can :edit, Item
      can :read, Item

      #can read full price history and create new price_history
      can :create, ItemPrice, :item_id => item.id #CHECK
      can :read, ItemPrice, :item_id => item.id

      #can adjust inventory levels by adding purchases
      can :create, Purchase

      #can view list of items that need to be reordered
      can :read, Item, Item.need_reorder #CHECK view or index

      #can read info about customers, schools, and orders
      can :read, School
      can :read, Order
      # can :read, User, role => customer


    elsif user.role? :shipper
      #read own personal info
      can :show, User do |u|
        u.id == user.id
      end

      #can read info related to orders that need to be shipped
      can :index, Order

      #can read info about items, but not price history
      can :read, Item do |this_item|

      end

    elsif user.role? :customer
      #read own personal info
      # can :show, User do |u|
      #   u.id == user.id
      # end
      # #edit name, phone, email, and password
      # can :update, User do |u|
      #   u.id ==user.id
      # end
      #
      #place new orders and cancel unshipped ones
      can :create, Order
      can :destroy, Order, Order.not_shipped #check!!!!

      #can read info about items no inventory level or price history DO IN THE VIEWS
      # can :index, Item

      #can add schools
      can :create, School


    else
      can :show, Item
      # #not inventory level and price history
      can :create, User
      #
      can :index, Item
      can :create, School
      # can :manage, :all



    end
  end
end
