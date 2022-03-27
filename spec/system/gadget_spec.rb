# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト'do
  let!(:occupation) {create(:occupation)}
  let!(:user) {create(:user,occupation_id: occupation.id)}
  let!(:gadget) {create(:gadget,user_id: user.id,price: 30000)}
  let!(:tag) {create(:tag,name: 'デジタル')}
  let!(:gadget_tag) {create(:gadget_tag,tag_id: tag.id,gadget_id: gadget.id)}
  describe 'ガジェット記事一覧画面のテスト' do
    before do
      # テスト前にログインを実施
      visit root_path
      click_on 'ログイン'
      fill_in 'user[email]',with: user.email
      fill_in 'user[password]',with: user.password
      click_on 'ログインする'
      click_link '投稿一覧'
    end
    context '表示の確認' do
      it 'ガジェット記事一覧のpathが"/gadgets"であるか' do
        expect(current_path).to eq('/gadgets')
      end
    end
  end
  describe "ガジェット投稿画面のテスト" do
    before do
       # テスト前にログインを実施
      visit root_path
      click_on('ログイン')
      fill_in('user[email]',with: user.email)
      fill_in('user[password]',with: user.password)
      click_on('ログインする')
      visit new_gadget_path
    end
    context '投稿処理に関するテスト' do
      it '投稿に成功し、成功メッセージが表示されるか' do
        fill_in 'gadget[name]',with: gadget.name
        fill_in 'gadget[manufacture_name]',with: gadget.manufacture_name
        fill_in 'gadget[tag_name]',with: Faker::JapaneseMedia::Naruto.character
        fill_in 'gadget[price]',with: gadget.price
        # 「xpath(XML Path Language)」：タグをパス形式で指定可能なメソッド？
        # 「visible: false」：画面上に表示されていない要素も対象とすることができる。
        # (gadget[score]は、hidden_fieldに設定しているため。)
        find(:xpath, "/html/body/main/div[2]/form/div[5]/div[2]/input",visible: false).set gadget.score
        fill_in 'gadget[description]',with: gadget.description
        click_button '投稿する'
        expect(page).to have_content "ガジェット記事を投稿しました。"
      end
      it '投稿に失敗した場合' do
        click_button '投稿する'
        expect(page).to have_content 'ガジェット記事の投稿ができませんでした。'
        expect(current_path).to eq('/gadgets/new')
      end
      it '投稿後のリダイレクト先は正しいか' do
        fill_in 'gadget[name]',with: gadget.name
        fill_in 'gadget[manufacture_name]',with: gadget.manufacture_name
        fill_in 'gadget[tag_name]',with: Faker::JapaneseMedia::Naruto.character
        fill_in 'gadget[price]',with: gadget.price
        find(:xpath, "/html/body/main/div[2]/form/div[5]/div[2]/input",visible: false).set gadget.score
        fill_in 'gadget[description]',with: gadget.description
        click_button '投稿する'
        expect(page).to have_current_path gadget_path(Gadget.last)
      end
    end
  end
  describe 'ガジェット詳細画面のテスト' do
    before do
      visit root_path
      click_on 'ログイン'
      fill_in 'user[email]',with: user.email
      fill_in 'user[password]',with: user.password
      click_on 'ログインする'
      visit gadget_path(gadget)
    end
    context '表示の確認' do
      it 'ガジェット記事に関連する情報が表示されているか' do
        expect(page).to have_content gadget.name
        expect(page).to have_content gadget.manufacture_name
        gadget.tags.each do |tag|
          expect(page).to have_link tag.name
        end
        expect(page).to have_content '30,000円'
        # レビュースコアの値が取得できない・・・
        expect(page).to have_selector "#score-output#{gadget.id}"
        expect(page).to have_content gadget.user.nickname
        expect(page).to have_content gadget.description
      end
      it 'ガジェット記事のお気に入り登録リンクが表示されているか' do
        expect(page).to have_link href: gadget_favorites_path(gadget)
      end
      it 'ガジェット記事の編集リンクが表示されているか' do
        expect(page).to have_link '編集'
      end
      it 'ガジェット記事の削除リンクが表示されているか' do
        expect(page).to have_link '削除'
      end
      it 'ガジェット記事に対するコメント投稿エリアが表示されているか' do
        expect(page).to have_selector 'table'
        expect(page).to have_field 'gadget_comment[comment]'
        expect(page).to have_button 'コメント投稿'
      end
    end
    context 'ガジェット記事削除のテスト' do
      it 'ガジェット記事の削除' do
        expect{ gadget.destroy }.to change{ Gadget.count }.by(-1)
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        click_link '編集'
        expect(current_path).to eq('/gadgets/'+gadget.id.to_s+'/edit')
      end
    end
  end
  describe '編集画面のテスト' do
    before do
      visit root_path
      click_on 'ログイン'
      fill_in 'user[email]',with: user.email
      fill_in 'user[password]',with: user.password
      click_on 'ログインする'
      visit gadget_path(gadget)
      click_link '編集'
    end
    context '表示の確認' do
      it '編集前の情報が各フォームに入力されている。' do
        expect(page).to have_field 'gadget[name]',with: gadget.name
        expect(page).to have_field 'gadget[manufacture_name]',with: gadget.manufacture_name
        display_tags = []
        gadget.tags.each do |tag|
          display_tags.push(tag.name)
        end
        expect(page).to have_field 'gadget[tag_name]',with: display_tags.join(" ")
        # レビュースコアの値が取得できない・・・
        expect(page).to have_selector "#score-output#{gadget.id}",visible: false
        expect(page).to have_field 'gadget[description]',with: gadget.description
      end
      it '更新するボタンが表示される' do
        expect(page).to have_button '更新する'
      end
      it 'ガジェット記事へ戻るリンクが表示される' do
        expect(page).to have_link 'ガジェット記事へ戻る'
      end
    end
    context 'リンクの遷移先の確認' do
      it 'ガジェット記事へ戻るの遷移先はガジェット記事詳細画面か' do
        click_link 'ガジェット記事へ戻る'
        expect(current_path).to eq('/gadgets/'+gadget.id.to_s)
      end
    end
    context '更新処理に関するテスト' do
      it '更新に成功し成功メッセージが表示されるか' do
        fill_in 'gadget[name]',with: gadget.name
        fill_in 'gadget[manufacture_name]',with: gadget.manufacture_name
        fill_in 'gadget[tag_name]',with: Faker::JapaneseMedia::Naruto.character
        fill_in 'gadget[price]',with: gadget.price
        # レビュースコアの値が設定できない・・・
        fill_in 'gadget[description]',with: gadget.description
        click_button '更新する'
        expect(page).to have_content '対象の投稿記事情報を更新しました。'
      end
      it '更新に失敗し失敗メッセージが表示されるか' do
        fill_in 'gadget[name]',with: ''
        fill_in 'gadget[manufacture_name]',with: ''
        click_button '更新する'
        expect(page).to have_content '対象の投稿記事情報を更新できませんでした。'
      end
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'gadget[name]',with: gadget.name
        fill_in 'gadget[manufacture_name]',with: gadget.manufacture_name
        fill_in 'gadget[tag_name]',with: Faker::JapaneseMedia::Naruto.character
        fill_in 'gadget[price]',with: gadget.price
        # レビュースコアの値が設定できない・・・
        fill_in 'gadget[description]',with: gadget.description
        click_button '更新する'
        expect(page).to have_current_path gadget_path(gadget.id)
      end
    end
  end
end