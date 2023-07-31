# frozen_string_literal: true

class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    user ||= User.new # гостевой пользователь (guest)
    @user = user

    if user.super_admin? || user.email == 'web.dev.adk@gmail.com'
      super_admin_abilities
    elsif user.admin?
      admin_abilities
    elsif user.student? || user.employee?
      student_and_employee_abilities
    elsif user.guest?
      guest_abilities
    else
      sample_user_abilities
    end
  end

  def super_admin_abilities
    # Права доступа для суперадминистратора
    can :manage, :all
  end

  def admin_abilities
    # Права доступа для администратора
    main_page_ability

    can :read, Group, id: user.group_id # Может смотреть только свою группу
    can :update, Group, id: user.group_id # Может обновлять только свою группу

    can :create, User, group_id: user.group_id # Может создавать пользователей только для своей группы
    can :read, User, group_id: user.group_id # Может смотреть пользователей только своей группы
    can :update, User, group_id: user.group_id # Может обновлять пользователей только своей группы
    can :destroy, User, group_id: user.group_id # Может удалять пользователей только своей группы

    can :read, Book # Может только смотреть книги
    can [:read, :filter], Category # Может только смотреть категории
  end

  def student_and_employee_abilities
    main_page_ability

    can :read, Book # Может только смотреть книги
    can [:read, :filter], Category # Может только смотреть категории
  end

  def guest_abilities
    main_page_ability

    can :show, Book # Может только смотреть страницу списков книг
    can :index, Book # Может только смотреть страницу списков книг
    can :filter, Category # Может только смотреть страницу фильтров по категориям
  end

  def sample_user_abilities

    can :show, Book # Может только смотреть страницу списков книг
    can :index, Book # Может только смотреть страницу списков книг
    can :filter, Category # Может только смотреть страницу фильтров по категориям
  end

  def main_page_ability
    can :read, 'main_pages/index' # Может только смотреть страницы
    can :read, 'main_pages/help' # Может только смотреть страницы
    can :read, 'main_pages/info' # Может только смотреть страницы
  end
end
