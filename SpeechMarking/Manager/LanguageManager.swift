//
//  LanguageManager.swift
//  SpeechMarking
//
//  Created by Brian 🌞 on 2022/11/3.
//

import Foundation
class LanguageManager :ObservableObject{
    
    //var languagecode = UserDefaults.standard.string(forKey: "languagecode")
    //var languagecode = "en"
    // var phonelogin = "Login by phone"
    // var accountlogin = "Login by account"
    static var shared_ = LanguageManager()
   
    @Published var inputaccount = "Please input your account number"
     var inputpassword = "Please input your password"
    @Published var loginviewtitle = "Sign in"
    
    
     var loginviewregister = "Register"
     var loginviewlogin = "Login"
     var returnok = "OK"
     var mainviewifupdate = "Is there a version update?"
    // var ifjumpsuccess = "Whether the jump is successful:"
    // var readytojump = "Ready to jump to the APP Store!"
     var taskviewdatalist = "Data Label List"
     var tasklistviewlogin = "Login"
     var tasklistviewtype = "Type："
     var tasklistviewlanguage = "Language："
     var tasklistviewdeadline = "Deadline："
     var inverification = "This task is in verification and cannot be marked temporarily"
     var markingviewdatamark = "Data marking"
     var markingviewtextmarkdouble = "Text marking - Bilingual"
     var markingviewloading = "Loading"
     var markingviewsrecord = "Source language record"
     var markingviewttext = "Target language text"
     var markingviewtrecord = "Target language record"
     var markingviewinputtext = "Please enter the text corresponding to this audio"
     var markingviewstartrecord = "Please click the button to start recording"
     var markingviewskip = "Skip"
     var markingviewnext = "Next"
     var markingviewerror = "Error"
     var markingviewnorecord = "The data is not recorded"
     var markingviewtextmarksingle = "Text marking - Monolingual"
     var markingviewvoicemarkdouble = "Voice marking - Bilingual"
     var markingviewvoicemarksingle = "Voice marking - Monolingual"
     var markingviewstext = "Source language text"
     var markingviewnomark = "The data is not marked"
     var registerviewreturnlogin = "Back to login"
     var registerviewregistration = "User registration"
     var registerviewsetaccount = "Please set the account"
     var registerviewsetpassword = "Please set the password"
     var registerviewnotempty = "The account or password cannot be blank. Please enter the account and password"
     var registerviewregister = "Register"
     var menuviewset = "Language Settings"
     var menuviewupdate = "Update Version"
     var menuviewnewest = "The current version is already the latest version"
     var menuviewdelete = "Delete account"
     var menuviewifdelete = "Are you sure to delete the current account? This operation is irreversible"
     var menuviewnotdelete = "No, let me think again"
     var menuviewnotlogin = "Don't log in temporarily"
     var menuviewnetwork = "Network Now:"
     var netchina = "China"
     var netother = "Any Other Country"
    
    
    func updatelanguage(languagecode:String){
        
        if languagecode == "zh"{
           
            inputaccount = "请输入账号"
            inputpassword = "请输入密码"
            LanguageManager.shared_.loginviewtitle = "用户登录"
            loginviewregister = "注册"
            loginviewlogin = "登录"
            returnok = "好的"
            mainviewifupdate = "是否进行版本更新？"
            taskviewdatalist = "数据标注列表"
            tasklistviewlogin = "登录"
            tasklistviewtype = "类型:"
            tasklistviewlanguage = "语言:"
            tasklistviewdeadline = "期限时间:"
            inverification = "该任务校验中，暂时不可标注"
            markingviewdatamark = "数据标注"
            markingviewtextmarkdouble = "文本标注-双语"
            markingviewloading = "正在加载"
            markingviewsrecord = "源语言录音"
            markingviewttext = "目标语言文本"
            markingviewtrecord = "目标语言录音"
            markingviewinputtext = "请输入该音频对应的文本"
            markingviewstartrecord = "请点击按钮开始录音"
            markingviewskip = "跳过"
            markingviewnext = "下一条"
            markingviewerror = "标注错误"
            markingviewnorecord = "该数据未录音"
            markingviewtextmarksingle = "文本标注-单语"
            markingviewvoicemarkdouble = "语音标注-双语"
            markingviewvoicemarksingle = "语音标注-单语"
            markingviewstext = "源语言文本"
            markingviewnomark = "该数据未标注"
            registerviewreturnlogin = "返回登录"
            registerviewregistration = "用户注册"
            registerviewsetaccount = "请设置账号"
            registerviewsetpassword = "请设置密码"
            registerviewnotempty = "账号或密码不得为空,请输入账号和密码"
            registerviewregister = "注册"
            menuviewset = "语言设置"
            menuviewupdate = "检查更新"
            menuviewnewest = "已是最新版本"
            menuviewdelete = "删除账户"
            menuviewifdelete = "确定删除当前账户吗？该操作不可逆"
            menuviewnotdelete = "不，我再想想"
            menuviewnotlogin = "暂不登录"
            menuviewnetwork = "当前网络环境:"
            netchina = "中国"
            netother = "其他国家"
        }
        
        if languagecode == "en"{
            inputaccount = "Please input your account number"
            inputpassword = "Please input your password"
            loginviewtitle = "Sign in"
            loginviewregister = "Register"
            loginviewlogin = "Login"
            returnok = "OK"
            mainviewifupdate = "Is there a version update?"
            taskviewdatalist = "Data Label List"
            tasklistviewlogin = "Login"
            tasklistviewtype = "Type："
            tasklistviewlanguage = "Language："
            tasklistviewdeadline = "Deadline："
            inverification = "This task is in verification and cannot be marked temporarily"
            markingviewdatamark = "Data marking"
            markingviewtextmarkdouble = "Text marking - Bilingual"
            markingviewloading = "Loading"
            markingviewsrecord = "Source language record"
            markingviewttext = "Target language text"
            markingviewtrecord = "Target language record"
            markingviewinputtext = "Please enter the text corresponding to this audio"
            markingviewstartrecord = "Please click the button to start recording"
            markingviewskip = "Skip"
            markingviewnext = "Next"
            markingviewerror = "Error"
            markingviewnorecord = "The data is not recorded"
            markingviewtextmarksingle = "Text marking - Monolingual"
            markingviewvoicemarkdouble = "Voice marking - Bilingual"
            markingviewvoicemarksingle = "Voice marking - Monolingual"
            markingviewstext = "Source language text"
            markingviewnomark = "The data is not marked"
            registerviewreturnlogin = "Back to login"
            registerviewregistration = "User registration"
            registerviewsetaccount = "Please set the account"
            registerviewsetpassword = "Please set the password"
            registerviewnotempty = "The account or password cannot be blank. Please enter the account and password"
            registerviewregister = "Register"
            menuviewset = "Language Settings"
            menuviewupdate = "Update Version"
            menuviewnewest = "The current version is already the latest version"
            menuviewdelete = "Delete account"
            menuviewifdelete = "Are you sure to delete the current account? This operation is irreversible"
            menuviewnotdelete = "No, let me think again"
            menuviewnotlogin = "Don't log in temporarily"
            menuviewnetwork = "Network Now:"
            netchina = "China"
            netother = "Any Other Country"
        }
        
        if languagecode == "vi"{
            inputaccount = "xin vui lòng nhập tài khoản "
            inputpassword = "nhập mật khẩu vào "
            loginviewtitle = "đăng nhập của người dùng "
            loginviewregister = "đăng ký "
            loginviewlogin = "đăng nhập "
            returnok = "được rồi ."
            mainviewifupdate = "bản cập nhật phiên bản có được thực hiện không ?"
            taskviewdatalist = "danh sách các ghi chú dữ liệu "
            tasklistviewlogin = "đăng nhập "
            tasklistviewtype = "kiểu kiểu "
            tasklistviewlanguage = "ngôn ngữ mập mạp "
            tasklistviewdeadline = "thời gian kỳ hạn kéo dài "
            inverification = "trong kiểm tra nhiệm vụ này , tạm thời không thể ghi chú . "
            markingviewdatamark = "ghi chú dữ liệu "
            markingviewtextmarkdouble = "ghi chú văn bản - song ngữ"
            markingviewloading = "đang tải "
            markingviewsrecord = "bản ghi ngôn ngữ nguồn "
            markingviewttext = "văn bản ngôn ngữ đích "
            markingviewtrecord = "bản ghi âm ngôn ngữ đích "
            markingviewinputtext = "vui lòng nhập văn bản tương ứng với âm thanh đó "
            markingviewstartrecord = "vui lòng bấm nút và bắt đầu ghi âm . "
            markingviewskip = "nhảy "
            markingviewnext = "kế tiếp "
            markingviewerror = "lỗi đánh dấu "
            markingviewnorecord = "dữ liệu chưa được ghi lại "
            markingviewtextmarksingle = "ghi chú văn bản - đơn ngữ "
            markingviewvoicemarkdouble = "chú thích giọng nói - song ngữ "
            markingviewvoicemarksingle = "chú thích giọng nói - đơn ngữ "
            markingviewstext = "văn bản ngôn ngữ nguồn "
            markingviewnomark = "dữ liệu không được đánh dấu "
            registerviewreturnlogin = "trở lại đăng nhập "
            registerviewregistration = "đăng ký người dùng "
            registerviewsetaccount = "xin vui lòng xác lập tài khoản "
            registerviewsetpassword = "làm ơn thiết lập mật khẩu "
            registerviewnotempty = "tài khoản hoặc mật khẩu không được để trống , vui lòng nhập tài khoản và mật khẩu "
            registerviewregister = "đăng ký "
            menuviewset = "cài đặt ngôn ngữ "
            menuviewupdate = "kiểm tra cập nhật "
            menuviewnewest = "đã là phiên bản mới nhất "
            menuviewdelete = "xóa tài khoản "
            menuviewifdelete = "bạn có quyết định xoá tài khoản hiện tại không ? thao tác này không thể đảo ngược "
            menuviewnotdelete = "không , tôi sẽ nghĩ lại . "
            menuviewnotlogin = "tạm thời không đăng nhập "
            menuviewnetwork = "môi trường mạng hiện tại "
            netchina = "trung quốc "
            netother = "nước khác "
        }
        
        if languagecode == "lo"{
            inputaccount = "ກະ ລຸ ນາ ໃສ່ ເລກ ບັນຊີ"
            inputpassword = "ກະ ລຸ ນາ ໃສ່ ລະຫັດ ຜ່ານ"
            loginviewtitle = "ການ ເຂົ້າ ສູ່ ລະບົບ ຂອງ ຜູ້ ໃຊ້"
            loginviewregister = "ລົງທະບຽນ"
            loginviewlogin = "ເຂົ້າ ສູ່ ລະບົບ"
            returnok = "ຕົກລົງ"
            mainviewifupdate = "ມີ ການປັບປຸງ ເ ວີ ຊັນ ບໍ?"
            taskviewdatalist = "ບັນຊີ ລາຍຊື່ ປ້າຍ ຊື່ ຂໍ້ ມູນ"
            tasklistviewlogin = "ເຂົ້າ ສູ່ ລະບົບ"
            tasklistviewtype = "ປະເພດ:"
            tasklistviewlanguage = "ພາສາ:"
            tasklistviewdeadline = "ກຳ ນ ົ ດ ເວລາ:"
            inverification = "ໃນ ການ ກວດສອບ ວຽກງານ ນີ້, ມັນ ບໍ່ສາມາດ ຖືກ ໝາ ຍ ໄວ້ ຊົ່ວຄາວ"
            markingviewdatamark = "ປ້າຍ ຊື່ ຂໍ້ ມູນ"
            markingviewtextmarkdouble = "ຄຳ ບັນຍາຍ ຂໍ້ຄວາມ-ສອງ ພາສາ"
            markingviewloading = "ກຳ ລ ັ ງ ໂ ຫ ລ ດ"
            markingviewsrecord = "ການ ບັນທຶກ ພາສາ ແ ຫ ຼ ່ ງ ຂໍ້ ມູນ"
            markingviewttext = "ຂໍ້ຄວາມ ພາສາ ເປົ້າ ໝາ ຍ"
            markingviewtrecord = "ການ ບັນທຶກ ພາສາ ເປົ້າ ໝາ ຍ"
            markingviewinputtext = "ກະ ລຸ ນາ ໃສ່ ຂໍ້ຄວາມ ທີ່ ສອດຄ້ອງກັບ ສຽງ"
            markingviewstartrecord = "ກະ ລຸ ນາ ກົດ ປຸ່ມ ເພື່ອ ເ ລີ່ ມ ການ ບັນທຶກ ສຽງ"
            markingviewskip = "ຂ້າມ"
            markingviewnext = "ຕໍ່ໄປ"
            markingviewerror = "ຂໍ້ ຜິດພາດ ໃນ ການ ຕິດ ສະຫຼາກ"
            markingviewnorecord = "ຂໍ້ ມູນ ບໍ່ໄດ້ ຖືກ ບັນທຶກ ໄວ້"
            markingviewtextmarksingle = "ຄຳ ບັນຍາຍ ຂໍ້ຄວາມ-ພາສາດຽວ"
            markingviewvoicemarkdouble = "ບັນຍາຍການອອກສຽງ - ສອງພາສາ"
            markingviewvoicemarksingle = "ຄຳອະທິບາຍອອກສຽງ-ພາສາດຽວ"
            markingviewstext = "ຂໍ້ຄວາມ ພາສາ ແ ຫ ຼ ່ ງ ຂໍ້ ມູນ"
            markingviewnomark = "ຂໍ້ ມູນ ບໍ່ໄດ້ ຖືກ ຕິດ ສະຫຼາກ"
            registerviewreturnlogin = "ກັບໄປ ເຂົ້າ ສູ່ ລະບົບ"
            registerviewregistration = "ການ ລົງທະບຽນ ຜູ້ ໃຊ້"
            registerviewsetaccount = "ກະ ລຸ ນາ ຕັ້ງ ບັນຊີ"
            registerviewsetpassword = "ກະ ລຸ ນາ ຕັ້ງ ລະຫັດ ຜ່ານ"
            registerviewnotempty = "ເລກ ບັນຊີ ຫ ລື ລະຫັດ ຜ່ານ ຕ້ອງ ບໍ່ຫວ່າງ, ກະ ລຸ ນາ ໃສ່ ເລກ ບັນຊີ ແລະ ລະຫັດ ຜ່ານ"
            registerviewregister = "ລົງທະບຽນ"
            menuviewset = "ການ ຕັ້ງ ຄ່າ ພາສາ"
            menuviewupdate = "ກວດເບິ່ງ ການປັບປຸງ"
            menuviewnewest = "ແມ່ນ ລຸ ້ ນ ລ້າ ສຸດ"
            menuviewdelete = "ລຶບ ບັນຊີ"
            menuviewifdelete = "ທ່ານ ແນ່ໃຈ ບໍ່ ທີ່ ຈະ ລຶບ ບັນຊີ ປະຈຸບັນ? ການ ປະຕິບັດງານ ແມ່ນ ບໍ່ສາມາດ ປ່ຽນແປງ ໄດ້"
            menuviewnotdelete = "ບໍ່ ຂ້ອຍ ຄິດ ອ ີ ກ ຄັ້ງ"
            menuviewnotlogin = "ຢ່າ ເຂົ້າ ສູ່ ລະບົບ"
            menuviewnetwork = "ສະພາບແວດລ້ອມເຄືອຂ່າຍໃນປະຈຸບັນ:"
            netchina = "ຈີນ"
            netother = "ປະເທດອື່ນ"
        }
        
        if languagecode == "km"{
            inputaccount = "សូមបញ្ចូលគណនី"
            inputpassword = "សូមបញ្ចូលពាក្យសម្ងាត់"
            loginviewtitle = "ការចូលរបស់អ្នកប្រើប្រាស់"
            loginviewregister = "ចុះឈ្មោះ"
            loginviewlogin = "ចូល"
            returnok = "យល់ព្រម"
            mainviewifupdate = "តើមានការធ្វើបច្ចុប្បន្នភាពកំណែទេ？"
            taskviewdatalist = "បញ្ជីចំណារពន្យល់ទិន្នន័យ"
            tasklistviewlogin = "ចូល"
            tasklistviewtype = "ប្រភេទ"
            tasklistviewlanguage = "ភាសា"
            tasklistviewdeadline = "ពេលវេលាផុតកំណត់"
            inverification = "នៅក្នុងការផ្ទៀងផ្ទាត់ភារកិច្ចនេះវាមិនអាចត្រូវបានសម្គាល់ជាបណ្តោះអាសន្នទេ"
            markingviewdatamark = "ចំណារពន្យល់ទិន្នន័យ"
            markingviewtextmarkdouble = "ចំណារពន្យល់អត្ថបទ-ពីរភាសា"
            markingviewloading = "កំពុងផ្ទុក"
            markingviewsrecord = "ការថតភាសាប្រភព"
            markingviewttext = "អត្ថបទភាសាគោលដៅ"
            markingviewtrecord = "ការថតភាសាគោលដៅ"
            markingviewinputtext = "សូមបញ្ចូលអត្ថបទដែលត្រូវនឹងសំលេង"
            markingviewstartrecord = "សូមចុចប៊ូតុងដើម្បីចាប់ផ្តើមថត"
            markingviewskip = "រំលង"
            markingviewnext = "បន្ទាប់"
            markingviewerror = "កំហុសក្នុងការដាក់ស្លាក"
            markingviewnorecord = "ទិន្នន័យមិនត្រូវបានកត់ត្រាទេ"
            markingviewtextmarksingle = "ចំណារពន្យល់អត្ថបទ-មនោគមវិជ្ជា"
            markingviewvoicemarkdouble = "ចំណារពន្យល់សុន្ទរកថា-ពីរភាសា"
            markingviewvoicemarksingle = "ចំណារពន្យល់សុន្ទរកថា-មនោគមវិជ្ជា"
            markingviewstext = "អត្ថបទភាសាប្រភព"
            markingviewnomark = "ទិន្នន័យមិនត្រូវបានសម្គាល់ទេ"
            registerviewreturnlogin = "ត្រឡប់ទៅចូលវិញ"
            registerviewregistration = "ការចុះឈ្មោះអ្នកប្រើប្រាស់"
            registerviewsetaccount = "សូមរៀបចំគណនី"
            registerviewsetpassword = "សូមកំណត់ពាក្យសម្ងាត់"
            registerviewnotempty = "គណនីឬពាក្យសម្ងាត់មិនត្រូវទទេសូមបញ្ចូលគណនីនិងពាក្យសម្ងាត់"
            registerviewregister = "ចុះឈ្មោះ"
            menuviewset = "ការកំណត់ភាសា"
            menuviewupdate = "ពិនិត្យបច្ចុប្បន្នភាព"
            menuviewnewest = "កំណែចុងក្រោយរួចទៅហើយ"
            menuviewdelete = "លុបគណនី"
            menuviewifdelete = "តើអ្នកពិតជាចង់លុបគណនីបច្ចុប្បន្នមែនទេ？ ប្រតិបត្តិការនេះមិនអាចត្រឡប់វិញបានទេ"
            menuviewnotdelete = "ទេខ្ញុំគិតម្តងទៀត"
            menuviewnotlogin = "មិនចូលសម្រាប់ពេលបច្ចុប្បន្ននេះទេ"
            menuviewnetwork = "បរិស្ថានបណ្តាញបច្ចុប្បន្ន៖"
            netchina = "ចិន"
            netother = "ប្រទេសផ្សេងទៀត"
        }
        
        if languagecode == "my"{
            inputaccount = "ကျေးဇူးပြုပြီးအကောင့်ထဲဝင်ပါ"
            inputpassword = "ကျေးဇူးပြုပြီးကုဒ်ထည့်ပါ"
            loginviewtitle = "အသုံးပြုသူlogin"
            loginviewregister = "မှတ်ပုံတင်"
            loginviewlogin = "ဝင်ပါ"
            returnok = "အိုကေ"
            mainviewifupdate = "ဗားရှင်းမွမ်းမံမှုများရှိပါသလား။"
            taskviewdatalist = "ဒေတာမှတ်သားစာရင်း"
            tasklistviewlogin = "ဝင်ပါ"
            tasklistviewtype = "အမျိုးအစား"
            tasklistviewlanguage = "ဘာသာစကား"
            tasklistviewdeadline = "နောက်ဆုံးသတ်မှတ်ရက်"
            inverification = "အဆိုပါလုပ်ငန်းတာဝန်စစ်ဆေးမှုများအတွက်ယခုအချိန်တွင်မှတ်သားရမည်ဖြစ်သည်"
            markingviewdatamark = "ဒေတာတံဆိပ်ကပ်ခြင်း"
            markingviewtextmarkdouble = "စာသားအမှတ်အသား-ဘာသာစကားနှစ်မျိုး"
            markingviewloading = "တင်နေသည်"
            markingviewsrecord = "အရင်းအမြစ်ဘာသာစကားမှတ်တမ်း"
            markingviewttext = "ပစ်မှတ်ဘာသာစကားစာသား"
            markingviewtrecord = "ပစ်မှတ်ဘာသာစကားမှတ်တမ်းတင်ခြင်း"
            markingviewinputtext = "ကျေးဇူးပြု၍အသံနှင့်သက်ဆိုင်သောစာသားကိုရိုက်ထည့်ပါ"
            markingviewstartrecord = "ကျေးဇူးပြုပြီးအသံသွင်းရန်ခလုတ်ကိုနှိပ်ပါ"
            markingviewskip = "ခုန်"
            markingviewnext = "နောက်တစ်ခု"
            markingviewerror = "အမှားမှတ်သားပါ"
            markingviewnorecord = "ဒီဒေတာကိုမှတ်တမ်းတင်မထားဘူး"
            markingviewtextmarksingle = "စာသားအမှတ်အသား-တစ်ခုတည်း"
            markingviewvoicemarkdouble = "အသံထွက်မှတ်သားခြင်း-ဘာသာစကားနှစ်မျိုး"
            markingviewvoicemarksingle = "အသံထွက်မှတ်စုများ-တစ်ခုတည်း"
            markingviewstext = "အရင်းအမြစ်စာသား"
            markingviewnomark = "အချက်အလက်များကိုမှတ်သားမထားပါ"
            registerviewreturnlogin = "ဝင်ရန်ပြန်သွားပါ"
            registerviewregistration = "အသုံးပြုသူမှတ်ပုံတင်"
            registerviewsetaccount = "ကျေးဇူးပြုပြီးအကောင့်တစ်ခုပေးပါ"
            registerviewsetpassword = "ကျေးဇူးပြုပြီးစကားဝှက်ပေးပါ"
            registerviewnotempty = "အကောင့်သို့မဟုတ်စကားဝှက်ကိုအချည်းနှီးမဖြစ်ရ။ကျေးဇူးပြု၍အကောင့်နှင့်စကားဝှက်ကိုရိုက်ထည့်ပါ"
            registerviewregister = "မှတ်ပုံတင်"
            menuviewset = "ဘာသာစကားဆက်တင်"
            menuviewupdate = "နောက်ဆုံးဗားရှင်းအတွက်စစ်ဆေးပါ"
            menuviewnewest = "၎င်း၏နောက်ဆုံးပေါ်ဗားရှင်း"
            menuviewdelete = "အကောင့်ဖျက်ပါ"
            menuviewifdelete = "လက်ရှိအကောင့်ကိုဖျက်ဖို့သေချာလား။ဒီစစ်ဆင်ရေးပြောင်းပြန်မဟုတ်ပါဘူး"
            menuviewnotdelete = "မဟုတ်ပါ၊ကျွန်ုပ်ထပ်မံစဉ်းစားပါမည်"
            menuviewnotlogin = "ခဏဆိုင်းအင်လုပ်ပါ"
            menuviewnetwork = "လက်ရှိကွန်ယက်ပတ်ဝန်းကျင်"
            netchina = "တရုတ်"
            netother = "အခြားနိုင်ငံများ"
        }
        
        if languagecode == "th"{
            inputaccount = "โปรดเข้าบัญชี"
            inputpassword = "โปรดเข้ารหัสผ่าน"
            loginviewtitle = "ผู้ใช้เข้าสู่ระบบ"
            loginviewregister = "ลงทะเบียน"
            loginviewlogin = "เข้าสู่ระบบ"
            returnok = "โอเค"
            mainviewifupdate = "มีการอัปเดตเวอร์ชันหรือไม่"
            taskviewdatalist = "รายการฐานข้อมูล"
            tasklistviewlogin = "เข้าสู่ระบบ"
            tasklistviewtype = "ปลากะพงชนิด"
            tasklistviewlanguage = "ภาษา"
            tasklistviewdeadline = "ระยะเวลา"
            inverification = "ในการตรวจสอบภารกิจนั้นไม่สามารถตรวจสอบได้ชั่วคราว"
            markingviewdatamark = "ปลากะพง"
            markingviewtextmarkdouble = "การแปลงข้อความ-สองภาษา"
            markingviewloading = "กำลังโหลด"
            markingviewsrecord = "การบันทึกภาษาต้นฉบับ"
            markingviewttext = "ตำราภาษาจีน"
            markingviewtrecord = "การบันทึกภาษา"
            markingviewinputtext = "โปรดป้อนข้อความที่ตรงกับเสียงนี้"
            markingviewstartrecord = "กรุณาคลิกปุ่มเพื่อเริ่มการบันทึก"
            markingviewskip = "ข้าม"
            markingviewnext = "ต่อไป"
            markingviewerror = "ผิดพลาด"
            markingviewnorecord = "ข้อมูลนี้ไม่ได้บันทึก"
            markingviewtextmarksingle = "การแปลงข้อความเป็นภาษาเดียว"
            markingviewvoicemarkdouble = "การพูดสองภาษา"
            markingviewvoicemarksingle = "การออกเสียง-คำเดียว"
            markingviewstext = "ข้อความภาษาต้นทาง"
            markingviewnomark = "ข้อมูลนี้ยังไม่ถูก"
            registerviewreturnlogin = "กลับเข้าสู่ระบบ"
            registerviewregistration = "การลงทะเบียนผู้ใช้"
            registerviewsetaccount = "กรุณาตั้งค่าบัญชี"
            registerviewsetpassword = "โปรดตั้งรหัสผ่าน"
            registerviewnotempty = "ไม่อนุญาตให้บัญชีหรือรหัสผ่านว่างเปล่าโปรดป้อนบัญชีและรหัสผ่าน"
            registerviewregister = "ลงทะเบียน"
            menuviewset = "การตั้งค่าภาษา"
            menuviewupdate = "ตรวจสอบการอัปเดต"
            menuviewnewest = "เป็นรุ่นล่าสุด"
            menuviewdelete = "ลบบัญชี"
            menuviewifdelete = "ยืนยันการลบบัญชีปัจจุบันหรือไม่มันไม่ค่อยดีเท่าไหร่"
            menuviewnotdelete = "ไม่ฉันจะกลับไป"
            menuviewnotlogin = "ไม่เข้าสู่ระบบชั่วคราว"
            menuviewnetwork = "สภาพแวดล้อมเครือข่ายปัจจุบัน"
            netchina = "ประเทศจีน"
            netother = "ประเทศอื่นๆ"
        }
    }
}
