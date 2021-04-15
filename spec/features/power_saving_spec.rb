feature 'power saving mode' do
    after { Capybara.reset_sessions! }
    
    scenario 'thermostat is in power saving mode by default' do
        visit('/')
        expect(page).to have_content 'power saving mode is on'
    end

    scenario 'thermostat can switch power saving mode off' do
        visit('/')
        page.find('#psm-off').click
        expect(page).not_to have_content 'power saving mode is on'
        expect(page).to have_content 'power saving mode is off'
    end

    scenario 'thermostat can switch power saving mode on' do
        visit('/')
        page.find('#psm-off').click
        expect(page).to have_content 'power saving mode is off'
        
        page.find('#psm-on').click
        expect(page).not_to have_content 'power saving mode is off'
        expect(page).to have_content 'power saving mode is on'
    end
end