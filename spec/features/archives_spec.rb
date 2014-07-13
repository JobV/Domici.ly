require 'rails_helper'


feature "archiving", :type => :feature do
  given(:organisation) { create(:hoa) }
  given(:user)         { create(:user, hoa: organisation) }

  context 'a single alert' do
    given(:alert)        { create(:alert, hoa: organisation, user: user)}

    scenario 'archive' do
      sign_in_and_visit_alert(alert)
      expect(alert.archived).to be false
      expect(page).to have_content 'Archiveer'

      click_on 'Archiveer'

      expect_last_alert_to_be_archived
    end

    scenario 'unarchive' do
      archive_alert(alert)
      sign_in_and_visit_alert(alert)
      expect(page).to have_content 'Haal uit archief'

      click_on 'Haal uit archief'

      expect_last_alert_to_be_archived(false)
    end
  end

  context 'multiple alerts' do
    before { user.add_role :moderator, user.hoa }
    given(:alerts) { create_various_alerts }

    scenario 'with status klaar' do
      expect_alerts_to_be_archived(alerts, false)
      sign_in user
      visit alerts_path
      click_on 'Archiveer alles op klaar'
      completed_alerts = alerts.select{ |a| a.progress == 'completed'}
      other_alerts = alerts.select{ |a| a.progress != 'completed'}
      expect_alerts_to_be_archived(completed_alerts)
      expect_alerts_to_be_archived(other_alerts, false)
    end
  end
end

def sign_in_and_visit_alert(alert)
  sign_in user
  visit alert_path(alert)
end

def archive_alert(alert)
  alert.archived = true
  alert.save!
end

def expect_last_alert_to_be_archived(archived = true)
  expect(Alert.last.archived).to be archived
end

def create_various_alerts
  alerts = []
  3.times do |t|
    alerts << create(:alert, user: user, hoa: organisation, progress: 'new')
    alerts << create(:alert, user: user, hoa: organisation, progress: 'in progress')
    alerts << create(:alert, user: user, hoa: organisation, progress: 'completed')
  end
  alerts
end

def expect_alerts_to_be_archived(alerts, archived = true)
  alerts.each { |a| expect(Alert.find(a.id).archived).to be archived }
end
