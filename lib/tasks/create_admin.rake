include Rails.application.routes.url_helpers

begin
  namespace :admin do
    task :create => :environment do
      puts "Podaj Adres Email Admina:"
      email = STDIN.gets
      puts "Podaj Haslo:"
      password = STDIN.gets
      unless email.strip!.blank? || password.strip!.blank?
        if Admin.create!(:email => email, :password => password)
          puts "Admin Serwisu zostal stworzony. Zaloguj sie #{new_admin_session_path}"
        else
          puts "Przepraszamy, wystapil blad podczas tworzenia konta Admina"
        end
      end
    end
  end
end
