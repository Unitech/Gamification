require 'webrat'

module WebratHelpers

  def log_in user = nil
    user ||= Factory :user, :email => 'gus@mangasgaming.com', :password => 'secret_password'
    unless user.confirmed?
      user.update_attribute :confirmed_at, Time.zone.now
      user.update_attribute :confirmation_token, nil
    end
    visit new_user_session_path
    within 'form.formtastic' do |scope|
      fill_in 'Email ou pseudo', :with => user.email
      fill_in 'Mot de passe', :with => user.password
      click_button 'S\'authentifier'
    end
    user
  end
  
  def log_out options = {}
    visit destroy_user_session_path(options)
  end

  def create_typus_admin role='admin'
    admin = TypusUser.create! :email    => "admin@tlfj.com",
                              :password => "password",
                              :role     => role,
                              :status   => true
    admin.status = true
    admin.preferences = {:locale => "fr"}
    admin.save!
    admin
  end

  def typus_login role='admin'
    basic_auth('admin', 'technet')
    # create_typus_admin role
    # visit "/admin"
    # fill_in "Email", :with => "admin@tlfj.com"
    # fill_in "typus_user_password", :with => "password"
    # click_button "Entrer"
  end

  def sign_up_filling
    fill_in 'Pseudo', :with => 'Robix'
    fill_in 'Mot de passe', :with => 'my_precious'
    fill_in 'Email', :with => 'robix@live.fr'
    choose 'Homme'
    select '2', :within => 'Date de naissance'
    select 'janvier', :within => 'Date de naissance'
    select '1937', :within => 'Date de naissance'
    check 'user_terms_of_service'
  end

  def play_game score, date = nil
    @participation = Participation.last
    game_name = @participation.competition_template.game.name.parameterize
    post client_only_api_workflow_path(
      :game_name => game_name,
      :securekey => @participation.secure_key,
      :play      => 8)

    hash = Digest::MD5.hexdigest("#{(score + 100)}#{@participation.secure_key}")
    post client_only_api_finish_path(:game_name => game_name, :score => score,
      :securekey => @participation.secure_key, :timeleft => 100, :secure_hash => hash)

    get client_only_api_quit_path :securekey => @participation.secure_key
    @participation.update_attribute(:finished_at, date) unless date.nil?
    follow_redirect!
  end
end
