feature 'viewing the temperature' do
    after { Capybara.reset_sessions! }

    scenario 'it is 20 degrees by default' do
        visit('/')
        expect(page.find('#temperature')).to have_content '20'
    end

    scenario 'temperature can be increased' do
        visit('/')
        page.find('#temperature-up').click
        expect(page).not_to have_content '20'
        expect(page).to have_content '21' 
    end

    scenario 'temperature can be decreased' do
        visit('/')
        page.find('#temperature-down').click
        expect(page).not_to have_content 20
        expect(page).to have_content 19
    end

    scenario 'there is a minimum of 10 degrees' do
        visit('/')
        11.times { page.find('#temperature-down').click }
        expect(page).to have_content 10
    end

    scenario 'there is a maximum of 25 degrees if power saving mode is on' do
        visit('/')
        page.find('#psm-on').click
        6.times { page.find('#temperature-up').click }
        expect(page).not_to have_content 26
        expect(page).to have_content 25
    end

    scenario 'there is a maximum of 32 degrees if power saving mode is on' do
        visit('/')
        page.find('#psm-off').click
        13.times { page.find('#temperature-up').click }
        expect(page).not_to have_content 33
        expect(page).to have_content 32
    end

    scenario 'temperature resets to 20 degrees' do
        visit('/')
        page.find('#temperature-up').click
        expect(page).to have_content '21'

        page.find('#temperature-reset').click
        expect(page).to have_content '20'
    end
end