--Update Function
function Update(data,Advertiser_Id)
--Shorted Redis Address
BaseHash = "Advertiser-"..Advertiser_Id..":"
--###################################################################################
----------------------------------------------
-------------- Required Locals ---------------
----------------------------------------------
--Serpent For Vardump
local Serpent = require("serpent")
--Redis To Connect
local Redis = require("redis")
--Save Data On Redis
local DataBase = Redis.connect("127.0.0.1",6379)
--Creator Id [Kia Pashang]
local KiaPashang = 446464161
--Your Channel Address
local ChannelAddress = "@accounSale"
----------------------------------------------
------------ Start Main Funtions -------------
----------------------------------------------
--Vardump
local function Vardump(value)
print "\n-------------------------------------------------------------- START"
print(Serpent.block(value,{comment=false}))
print "--------------------------------------------------------------- STOP\n"
end
--Dl_Cb
local function Dl_Cb(extra,result)
--print "\n===================================================================="
--Vardump(extra)
--Vardump(result)
--print "--==================================================================\n"
end
--KIKI For Printing Vardump
local function KIKI(extra,result)
print "\n===================================================================="
Vardump(extra)
Vardump(result)
print "--==================================================================\n"
end
--Send Text
local function SendText(chat_id,msg_id,text,Dl_Cb,data)
local function ret_parsed(error,parsed_text)
tdbot_function({["@type"] = "sendMessage",chat_id = chat_id,reply_to_message_id = msg_id,disable_notification = true,from_background = true,reply_markup = nil,input_message_content = {["@type"] = "inputMessageText",text = {["@type"] = "formattedText",text = parsed_text.text, entities = {}},disable_web_page_preview = true,clear_draft = false},},callback or Dl_Cb,data)
end
tdbot_function({["@type"] = "parseTextEntities",text = text,parse_mode = {["@type"]= "textParseModeHTML"}},ret_parsed,data)
end
--Send Mention
local function SendMention(chat_id,msg_id,text,offset,length,userid,Dl_Cb,data)
local function ret_parsed(error, parsed_text)
tdbot_function ({["@type"] = "sendMessage",chat_id = chat_id,reply_to_message_id = msg_id,disable_notification = false,from_background = true,reply_markup = nil,input_message_content = {["@type"] = "inputMessageText",text = {["@type"]="formattedText", text = parsed_text.text,disable_web_page_preview = true,clear_draft = true,entities = {[0] = {["@type"] = "textEntity",length = length,offset = offset,type = {["@type"] = "textEntityTypeMentionName",user_id = userid}}},text = text}}},callback or Dl_Cb,data)
end
tdbot_function({["@type"] = "parseTextEntities",text = text,parse_mode = {["@type"]= "textParseModeHTML"}},ret_parsed,data)
end
--MarkRead
local function ViewMessages(chatid,messageids,callback,data)
tdbot_function({["@type"] = "viewMessages",chat_id = chatid,message_ids = messageids},callback or Dl_Cb,data)
end
--Delete All Chats
local function DeleteChats(chatid,removefromchatlist,callback,data)
tdbot_function({["@type"] = "deleteChatHistory",chat_id = chatid,remove_from_chat_list = removefromchatlist},callback or Dl_Cb,data)
end
--Check Chat Link
local function CheckChatLink(invitelink,callback,data)
tdbot_function({["@type"] = "checkChatInviteLink",invite_link = invitelink},callback or Dl_Cb,data)
end
--Import Chat Link
local function ImportChatLink(invitelink,callback,data)
tdbot_function({["@type"] = "joinChatByInviteLink",invite_link = invitelink},callback or Dl_Cb,data)
end
--Send Action
local function SendAction(chatid,act,uploadprogress,callback,data)
tdbot_function({["@type"] = "sendChatAction",chat_id = chatid,action = {["@type"] = "chatAction" .. act,progress = uploadprogress},},callback or Dl_Cb,data)
end
--Change Chat Member Status
local function SetChatMemberStatus(chatid,userid,rank,right,callback,data)
local chat_member_status = {}
if rank == "Administrator" then
chat_member_status = {can_be_edited = right[1] or 1,can_change_info = right[2] or 1,can_post_messages = right[3] or 1,can_edit_messages = right[4] or 1,can_delete_messages = right[5] or 1,can_invite_users = right[6] or 1,can_restrict_members = right[7] or 1,can_pin_messages = right[8] or 1,can_promote_members = right[9] or 1}
elseif rank == "Restricted" then
chat_member_status = {is_member = right[1] or 1,restricted_until_date = right[2] or 0,can_send_messages = right[3] or 1,can_send_media_messages = right[4] or 1,can_send_other_messages = right[5] or 1,can_add_web_page_previews = right[6] or 1}
elseif rank == "Banned" then
chat_member_status = {banned_until_date = right[1] or 0}
end
chat_member_status["@type"] = "chatMemberStatus" .. rank
tdbot_function({["@type"] = "setChatMemberStatus",chat_id = chatid,user_id = userid,status = chat_member_status},callback or Dl_Cb,data)
end
--Get Me
local function GetMe(callback,data)
tdbot_function({["@type"] = "getMe"},callback or Dl_Cb,data)
end
--Get User
local function GetUser(userid,callback,data)
tdbot_function({["@type"] = "getUser",user_id = userid},callback or Dl_Cb,data)
end
--Send Contact
local function SendContact(chatid,replytomessageid,disablenotification,frombackground,replymarkup,phonenumber,firstname,lastname,userid,callback,data)
tdbot_function ({["@type"] = "sendMessage",chat_id = chatid,reply_to_message_id = replytomessageid,disable_notification = disablenotification,from_background = frombackground,reply_markup = replymarkup,input_message_content = {["@type"] = "inputMessageContact",contact = {["@type"] = "Contact",phone_number = tostring(phonenumber),first_name = tostring(firstname),last_name = tostring(lastname),user_id = userid},},},callback or Dl_Cb,data)
end
--Import Contact
local function ImportContact(phonenumber,firstname,lastname,userid,callback,data)
tdbot_function({["@type"] = "importContacts",contacts = {[0] = {["@type"] = "contact",phone_number = phonenumber,first_name = firstname,last_name = lastname,user_id = userid}}},callback or Dl_Cb,data)
end
--Search Contact
local function SearchContacts(que,lim,callback,data)
tdbot_function({["@type"] = "searchContacts",query = tostring(que),limit = lim},callback or Dl_Cb,data)
end
--Add Chat Member
local function AddChatMember(chatid,userid,forwardlimit,callback,data)
tdbot_function({["@type"] = "addChatMember",chat_id = chatid,user_id = userid,forward_limit = forwardlimit},callback or Dl_Cb,data)
end
--Get Chats
local function GetChats(offsetorder,offsetchatid,lim,callback,data)
tdbot_function({["@type"] = "getChats",offset_order = offsetorder,offset_chat_id = offsetchatid,limit = lim},callback or Dl_Cb,data)
end
--Get Chat
local function GetChat(chatid,callback,data)
tdbot_function ({["@type"] = "getChat",chat_id = chatid},callback or Dl_Cb,data)
end
--Open Chat
local function OpenChats(chatid,callback,data)
tdbot_function({["@type"] = "openChat",chat_id = chatid},callback or Dl_Cb,data)
end
--Get Message
local function GetMessage(chatid,messageid,callback,data)
tdbot_function({["@type"] = "getMessage",chat_id = chatid,message_id = messageid},callback or Dl_Cb,data)
end
--Search Public Chat
local function SearchPublicChat(username,callback,data)
tdbot_function({["@type"] = "searchPublicChat",username = tostring(username)},callback or Dl_Cb,data)
end
--Forward Message
local function Forward(chatid,fromchatid,messageids,disablenotification,frombackground,callback,data)
tdbot_function({["@type"] = "forwardMessages",chat_id = chatid,from_chat_id = fromchatid,message_ids = messageids,disable_notification = disablenotification or 0,from_background = frombackground or 1},callback or Dl_Cb,data)
end
--Set Name
local function SetName(first_name,last_name,callback,data)
tdbot_function ({["@type"] = "setName",first_name = tostring(first_name),last_name = tostring(last_name)},callback or Dl_Cb,data)
end
--Set Bio
local function SetBio(bio,callback,data)
tdbot_function ({["@type"] = "setBio",bio = tostring(bio)},callback or Dl_Cb,data)
end
--Download File
local function DownloadFile(file_id,priority,callback,data)
tdbot_function ({["@type"] = "downloadFile",file_id = file_id,priority = priority or 32},callback or Dl_Cb,data)
end
--Set Profile Photo
function SetProfilePhoto(photo,callback,data)
tdbot_function ({["@type"] = "setProfilePhoto",photo = getInputFile(photo)},callback or Dl_Cb,data)
end
--Reload Bot
local function Reload()
Advertiser = dofile("./Advertiser.lua")
end
----------------------------------------------
-------------- End Main Funtions -------------
----------------------------------------------
--#----------------------------------------#--
----------------------------------------------
--------- Start Message Check Funtion --------
----------------------------------------------
--Run Command From Bot
local function RunBash(str)
local cmd = io.popen(str)
local Result = cmd:read("*all")
return Result
end
--Kia Pashang Message
local function Kia(msg)
local Var = false
if msg.sender_user_id == tonumber(KiaPashang) then
Var = true
end
return Var
end
--Bot Full Admin Message
local function Leader(msg)
local Var = false
if msg.sender_user_id == tonumber(DataBase:get(BaseHash.."FullAdmin")) then
Var = true
elseif msg.sender_user_id == tonumber(KiaPashang) then
Var = true
end
return Var
end
--Bot Admis Message
local function Admin(msg)
local Var = false
local Admins = DataBase:sismember(BaseHash.."Admins",msg.sender_user_id)
if Admins then
Var = true
elseif msg.sender_user_id == tonumber(DataBase:get(BaseHash.."FullAdmin")) then
Var = true
elseif msg.sender_user_id == tonumber(KiaPashang) then
Var = true
end
return Var
end
--Get Bot Informations
local function GetBot(extra,result)
DataBase:del(BaseHash.."Id")
function BotInfo(extra,result)
DataBase:set(BaseHash.."Id",result.id)
if result.first_name then
DataBase:set(BaseHash.."FirstName",result.first_name)
end
if result.last_name then
DataBase:set(BaseHash.."LastName",result.last_name)
end
if result.phone_number then
DataBase:set(BaseHash.."PhoneNumber",result.phone_number)
end
return result.id
end
GetMe(BotInfo,data)
end
--Bot Message
local function Bot(msg)
local Var = false
local Bot = tonumber(DataBase:get(BaseHash.."Id")) or GetBot()
if msg.sender_user_id == Bot then
Var = true
end
return Var
end
--Save Links
local function SaveLinks(text)
local text = text or ""
if text:match("https://telegram.me/joinchat/%S+") or text:match("https://t.me/joinchat/%S+") then
local text = text:gsub("t.me","telegram.me")
for Link in text:gmatch("(https://telegram.me/joinchat/%S+)") do
if not DataBase:sismember(BaseHash.."WaitLinks",Link) and not DataBase:sismember(BaseHash.."GoodLinks",Link) and not DataBase:sismember(BaseHash.."JoinedLinks",Link) and not DataBase:sismember(BaseHash.."JunkLinks",Link) then
DataBase:sadd(BaseHash.."WaitLinks",Link)
end
end
end
end
--Dont Join Advertising SuperGroups
local function Advertising(name)
local Var = false
if name then
if name:match("تبلیغ") then
Var = true
elseif name:match("لینک") then
Var = true
elseif name:match("تبلیغات") then
Var = true
elseif name:match("اگهی") then
Var = true
elseif name:match("آگهی") then
Var = true
elseif name:match("تبادل") then
Var = true
elseif name:match("دیوار") then
Var = true
elseif name:match("شیپور") then
Var = true
elseif name:match("شارژ") then
Var = true
elseif name:match("sharge") then
Var = true
elseif name:match("charge") then
Var = true
elseif name:match("add kon") then
Var = true
elseif name:match("add") then
Var = true
elseif name:match("ادد کن") then
Var = true
elseif name:match("ادد") then
Var = true
elseif name:match("اد کن") then
Var = true
elseif name:match("تبلیغاتی") then
Var = true
elseif name:match("Add") then
Var = true
elseif name:match("Add Kon") then
Var = true
elseif name:match("درخواست") then
Var = true
elseif name:match("درخواستی") then
Var = true
elseif name:match("موسیقی") then
Var = true
elseif name:match("موزیک") then
Var = true
elseif name:match("آهنگ") then
Var = true
elseif name:match("اهنگ") then
Var = true
elseif name:match("music") then
Var = true
elseif name:match("Music") then
Var = true
elseif name:match("Sex") then
Var = true
elseif name:match("sex") then
Var = true
elseif name:match("Ads") then
Var = true
elseif name:match("ads") then
Var = true
elseif name:match("Charge") then
Var = true
elseif name:match("Sharge") then
Var = true
elseif name:match("تست") then
Var = true
elseif name:match("Test") then
Var = true
elseif name:match("پشتیبانی") then
Var = true
elseif name:match("support") then
Var = true
elseif name:match("Support") then
Var = true
elseif name:match("کسب و کار") then
Var = true
elseif name:match("همسریابی") then
Var = true
elseif name:match("شیر اکانت") then
Var = true
elseif name:match("Share") then
Var = true
elseif name:match("share") then
Var = true
elseif name:match("Share Contact") then
Var = true
elseif name:match("share contact") then
Var = true
elseif name:match("Contact") then
Var = true
elseif name:match("contact") then
Var = true
elseif name:match("همراه اول") then
Var = true
elseif name:match("ایرانسل") then
Var = true
elseif name:match("رایتل") then
Var = true
elseif name:match("Hamrah Aval") then
Var = true
elseif name:match("RighTel") then
Var = true
elseif name:match("Irancell") then
Var = true
elseif name:match("محصول") then
Var = true
elseif name:match("فروش") then
Var = true
elseif name:match("بازرگانی") then
Var = true
elseif name:match("sin") then
Var = true
elseif name:match("Sin") then
Var = true
elseif name:match("Seen") then
Var = true
elseif name:match("seen") then
Var = true
elseif name:match("بازدید") then
Var = true
elseif name:match("Bazdid") then
Var = true
elseif name:match("bazdid") then
Var = true
elseif name:match("خرید") then
Var = true
elseif name:match("Buy") then
Var = true
elseif name:match("buy") then
Var = true
elseif name:match("ضدلینک") then
Var = true
elseif name:match("تصت") then
Var = true
elseif name:match("صین") then
Var = true
end
return Var
end
end
--Check Links
local function CheckLinks(extra,result)
if (result.type and (result.type["@type"] == "chatTypeSupergroup" and not result.type.is_channel)) then
if not Advertising(result.title) then
DataBase:srem(BaseHash.."WaitLinks",extra.Link)
DataBase:sadd(BaseHash.."GoodLinks",extra.Link)
else
DataBase:srem(BaseHash.."WaitLinks",extra.Link)
DataBase:sadd(BaseHash.."JunkLinks",extra.Link)
end
else
DataBase:srem(BaseHash.."WaitLinks",extra.Link)
DataBase:sadd(BaseHash.."JunkLinks",extra.Link)
end
if result.code == 429 then
local message = tostring(result.message)
local Time = tonumber(message:match("%d+")) + 30
DataBase:setex(BaseHash.."AutoCheckTime",tonumber(Time),true)
end
end
--Join Links
local function JoinLinks(extra,result)
if result.code == 429 then
local message = tostring(result.message)
local Time = tonumber(message:match("%d+")) + 30
DataBase:setex(BaseHash.."AutoJoinTime",tonumber(Time),true)
else
DataBase:srem(BaseHash.."GoodLinks",extra.Link)
DataBase:sadd(BaseHash.."JoinedLinks",extra.Link)
end
end
--Chat Type
local function Chat_Type(id)
id = tostring(id)
if id:match("-") then
if id:match("-100") then
return "SuperGroup"
else
return "NormalGroup"
end
else
return "Private"
end
end
--Add Place Id To Panel
local function Add(id)
Place = Chat_Type(id)
if Place == "Private" then
DataBase:sadd(BaseHash.."Privates",id)
DataBase:sadd(BaseHash.."All",id)
elseif Place == "SuperGroup" then
DataBase:sadd(BaseHash.."SuperGroups",id)
DataBase:sadd(BaseHash.."All",id)
end
return true
end
--Remove Place Id From Panel
local function Rem(id)
Place = Chat_Type(id)
if Place == "Private" then
DataBase:srem(BaseHash.."Privates",id)
DataBase:srem(BaseHash.."All",id)
elseif Place == "SuperGroup" then
DataBase:srem(BaseHash.."SuperGroups",id)
DataBase:srem(BaseHash.."All",id)
end
return true
end
--Remove Numbers When Message Is From Telegram
local function RemoveNumbers(text)
text = tostring(text)
if text:match("1") then
text = text:gsub("1","1️⃣")
end
if text:match("2") then
text = text:gsub("2","2️⃣")
end
if text:match("3") then
text = text:gsub("3","3️⃣")
end
if text:match("4") then
text = text:gsub("4","4️⃣")
end
if text:match("5") then
text = text:gsub("5","5️⃣")
end
if text:match("6") then
text = text:gsub("6","6️⃣")
end
if text:match("7") then
text = text:gsub("7","7️⃣")
end
if text:match("8") then
text = text:gsub("8","8️⃣")
end
if text:match("9") then
text = text:gsub("9","9️⃣")
end
if text:match("0") then
text = text:gsub("0","🔟")
end
return text
end
----------------------------------------------
---------- End Message Check Funtion ---------
----------------------------------------------
--Help Texts
--Main Text
local MainText = [[
💠 راهنمای ربات تبچی AG 💠

> راهنمای سودو
❗راهنمای دستورات برای سودو اصلی

> راهنمای اصلی
❗راهنمای دستورات برای مدیران ربات

@accounSale
]]
--Full Admin Help
local FullAdminHelp = [[
راهنمای سودو ربات :

> ریلود
❗بروزرسانی فایلهای ربات

> تنظیم تصویر [ ریپلای ]
❗تنظیم تصویر برای ربات

> تنظیم اسم 
❗تنظیم اسم جدید ربات

> تنظیم درباره 
❗تنظیم درباره ربات

> بازنشانی [ همه - تنظیمات - کلی ]
❗بروزرسانی اطلاعات ذخیره شده

> افزودن مدیر [ ریپلای | ایدی | یوزرنیم ]
❗تنظیم مدیر برای ربات

> حذف مدیر [ ریپلای | ایدی | یوزرنیم ]
❗حذف فـرد از لیست مدیرهای ربات

> پاکسازی لیست مدیران
❗پاکسازی تمامی مدیرهای ربات

> لیست مدیران
❗دریافت و مشاهده مدیرهای ربات

> تنظیم گروه مدیریت
❗تایید گروه پشتیبانی برای ربات

> حذف گروه مدیریت
❗برکناری گروه از حالت پشتیبانی

> پاکسازی گروه مدیریت
❗حذف و پاکسازی گروه مدیریت


@accounSale
]]
--General Help
local GeneralHelp = [[
راهنمای اصلی ربات :

> انلاینی
❗اطلاع از حالت آنلاین ربات

> انلاین
❗اطلاع از ریپ چتِ ربات

> آمار
❗مشاهده آمـار ربات

> تنظیمات
❗مشاهده تنظیمات ربات

> شماره ربات
❗دریافت شماره ربات

> ترک سوپرگروه
❗لفت از سوپرگروه فعلی

> ترک همه
❗پاکسازی کلی گروهای ربات

> افزودن مخاطبین
❗دعوت مخاطبهای ذخیره شده به گروه

> اکو [ پیام ]
❗بازگویی پیام تأیین شده

> پیام عضویت [ روشن - خاموش ]
❗فعالسازی حالت پیام عضویت اجباری

> تنظیم پیام عضویت [ متن ]
❗تنظیم پیام عضویت اجباری

> ذخیره مخاطب
❗فعالسازی حالت ذخیره مخاطب

> عضویت خودکار [ روشن - خاموش ] 
❗ورود خودکار برای سوپرگروه

> خواندن پیام [ روشن - خاموش ]
❗فعالسازی حالت مشاهده پیام

> افزودن به همه
❗دعوت فرد به تمامی گروهای ربات

> پاکسازی لینک ها 
❗پاک کردن تمامی لینک های دخیره شده

> ارسال به [ همه - کاربران - سوپرگروه ها ]
❗فروارد پیام

> ارسال زماندار خودکار روشن [ روشن - خاموش ]
❗فعال و غیر فعال کردن حالت هوشمند فوروارد زمانی

> تنظیم ارسال زماندار خودکار [ زمان ] [ تعداد تکرار ] 
❗تنظیم فروارد خودکار

> ارسال زماندار خودکار به [ همه - کاربران - سوپرگروه ها ]
❗ تنظیم حالت فروارد خودکار 

> لیست ارسال زماندار خودکار
❗ نمایش پست های فروارد خودکار

> پاکسازی لیست ارسال زماندار خودکار
❗ پاک کردن تمامی پست های فروارد خودکار

@accounSale
]]
--###################################################################################
--Opening Chats
if not DataBase:get(BaseHash.."TimeOpenChats") then
local SuperGroups = DataBase:smembers(BaseHash.."SuperGroups")
OpenChats(tonumber(KiaPashang),callback,data)
OpenChats(DataBase:get(BaseHash.."FullAdmin"),callback,data)
OpenChats(tostring(DataBase:get(BaseHash.."ManagerSuperGroup")),callback,data)
local function OpeningChats(extra,result)
local Chats = result.chat_ids or {}
if #Chats ~= 0 then
for i=0,#Chats do
OpenChats(tostring(Chats[i]),callback,data)
end
end
end
GetChats("9223372036854775807",0,99999,OpeningChats,data)
for i=1,#SuperGroups do
OpenChats(tostring(SuperGroups[i]),callback,data)
end
DataBase:setex(BaseHash.."TimeOpenChats",10,true)
end
--Leave Channels
if not DataBase:get(BaseHash.."TimeLeaveChannels") then
local function LeaveChannels(extra,result)
local Chats = result.chat_ids or {}
if #Chats ~= 0 then
for i=0,#Chats do
if tostring(Chats[i]):match("-100(%d+)") then
function CheckChannels(extra,result)
if (result.type["@type"] == "chatTypeSupergroup" and result.type.is_channel == true) then
SetChatMemberStatus(extra.id,tonumber(DataBase:get(BaseHash.."Id")),"Left",1,Dl_Cb,data)
Rem(extra.id)
end
end
GetChat(Chats[i],CheckChannels,{id = Chats[i]})
end
end
end
end
GetChats("9223372036854775807",0,99999,LeaveChannels,data)
DataBase:setex(BaseHash.."TimeLeaveChannels",3600,true)
end
--Cleaning Caches
if not DataBase:get(BaseHash.."TimeCleanCache") then
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/data/stickers/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/data/wallpapers/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/data/thumbnails/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/data/temp/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/data/secret_thumbnails/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/data/secret/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/data/profile_photos/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/files/voice/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/files/videos/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/files/video_notes/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/files/temp/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/files/photos/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/files/music/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/files/documents/*")
RunBash("sudo rm -rf ~/.telegram-bot/advertiser-"..Advertiser_Id.."/files/animations/*")
DataBase:setex(BaseHash.."TimeCleanCache",3600,true)
end
--Time Forward If Its On
if DataBase:get(BaseHash.."SwitchTimeForward") then
local Msgs = DataBase:smembers(BaseHash.."TimesToTimeForward")
if #Msgs > 0 and not DataBase:get(BaseHash.."DontTimeForward") then
local TtlsToTimeForward = {}
for i = 1, #Msgs do
local TtlToTimeForward = DataBase:ttl(BaseHash.."NotSendTimeForward"..Msgs[i])
if TtlToTimeForward <= 0 then
local Mttl = DataBase:get(BaseHash.."TtlToTimeForward"..Msgs[i])
local Privates,SuperGroups,All = DataBase:smembers(BaseHash.."Privates"),DataBase:smembers(BaseHash.."SuperGroups"),DataBase:smembers(BaseHash.."All")
local MsgId = Msgs[i]
--Time Forward To Privates
if DataBase:get(BaseHash.."TimeForwardStatus") == "Privates" then
for i=1,#Privates do
Forward(Privates[i],DataBase:get(BaseHash.."FromChatIdToTimeForward"..MsgId),{[0] = MsgId},0,1,Dl_Cb,data)
end
end
--Time Forward To SuperGroups
if DataBase:get(BaseHash.."TimeForwardStatus") == "SuperGroups" then
for i=1,#SuperGroups do
Forward(SuperGroups[i],DataBase:get(BaseHash.."FromChatIdToTimeForward"..MsgId),{[0] = MsgId},0,1,Dl_Cb,data)
end
end
--Time Forward To SuperGroups And Privates
if not DataBase:get(BaseHash.."TimeForwardStatus") then
for i=1,#All do
Forward(All[i],DataBase:get(BaseHash.."FromChatIdToTimeForward"..MsgId),{[0] = MsgId},0,1,Dl_Cb,data)
end
end
DataBase:setex(BaseHash.."NotSendTimeForward"..MsgId,Mttl,true)
DataBase:incrby(BaseHash.."TimesForTimeForward"..MsgId, -1)
if 0 >= tonumber(DataBase:get(BaseHash.."TimesForTimeForward"..MsgId)) then
DataBase:srem(BaseHash.."TimesToTimeForward",MsgId)
end
else
table.insert(TtlsToTimeForward,TtlToTimeForward)
end
end
table.sort(TtlsToTimeForward)
if TtlsToTimeForward[1] then
DataBase:setex(BaseHash.."DontTimeForward",TtlsToTimeForward[1],true)
end
end
end
--Auto Save Links
if DataBase:get(BaseHash.."AutoJoin") then
--Check Saved Links
if not DataBase:get(BaseHash.."AutoCheckTime") then
if DataBase:scard(BaseHash.."WaitLinks") ~= 0 then
local Links = DataBase:smembers(BaseHash.."WaitLinks")
for x,y in ipairs(Links) do
if x == 2 then
DataBase:setex(BaseHash.."AutoCheckTime",30,true)
return
end
CheckChatLink(y,CheckLinks,{Link = y})
end
end
end
--Join Checked Links
if not DataBase:get(BaseHash.."AutoJoinTime") then
if DataBase:scard(BaseHash.."GoodLinks") ~= 0 then
local Links = DataBase:smembers(BaseHash.."GoodLinks")
for x,y in ipairs(Links) do
ImportChatLink(y,JoinLinks,{Link = y})
if x == 2 then
DataBase:setex(BaseHash.."AutoJoinTime",30,true)
return
end
end
end
end
end
--Start Update New Message
if (data["@type"] == "updateNewMessage") then
--Shorted data.message to msg
local msg = data.message
--Places
local Place = Chat_Type(msg.chat_id)
--Get Bot Id
local BOTID = tonumber(DataBase:get(BaseHash.."Id")) or GetBot()
--Add Place To Redis
Add(msg.chat_id)
--Message Types
if msg.content then
Type_Inline = nil
Type_WebPage = nil
Type_Markdown = nil
Type_Forward = nil
Type_Mention = nil
Tg_Type = nil
if msg.content["@type"] == "messageText" then
Msg_Type = "Text"
elseif msg.content["@type"] == "messagePhoto" then
Msg_Type = "Photo"
elseif msg.content["@type"] == "messageChatAddMembers" then
Msg_Type = "TgService"
Tg_Type = "AddMember"
elseif msg.content["@type"] == "messageChatJoinByLink" then
Msg_Type = "TgService"
Tg_Type = "JoinByLink"
elseif msg.content["@type"] == "messageChatDeleteMember" then
Msg_Type = "TgService"
Tg_Type = "DeleteMember"
elseif msg.content["@type"] == "messageDocument" then
Msg_Type = "Document"
elseif msg.content["@type"] == "messageSticker" then
Msg_Type = "Sticker"
elseif msg.content["@type"] == "messageAudio" then
Msg_Type = "Audio"
elseif msg.content["@type"] == "messageGame" then
Msg_Type = "Game"
elseif msg.content["@type"] == "messageVoice" then
Msg_Type = "Voice"
elseif msg.content["@type"] == "messageVideo" then
Msg_Type = "Video"
elseif msg.content["@type"] == "messageAnimation" or msg.content["@type"] == "messageDocument" and msg.content.document and msg.content.document.mime_type == "image/gif" then
Msg_Type = "Gif"
elseif msg.content["@type"] == "messageLocation" then
Msg_Type = "Location"
elseif msg.content["@type"] == "messageVideoNote" then
Msg_Type = "VideoNote"
elseif msg.content["@type"] == "messagePinMessage" then
Msg_Type = "Pin"
elseif msg.content["@type"] == "messageContact" then
Msg_Type = "Contact"
else
Msg_Type = "TgService"
end
if Msg_Type == "Text" then
--Shorted msg.content.text.text to text
local text = msg.content.text.text
if msg.content.text.entities then
if msg.content.text.entities[0] then
local entities = msg.content.text.entities
for i=0,#entities do
if entities[i]["@type"] == "textEntity" then
if entities[i].type["@type"] == "textEntityTypeBold" or entities[i].type["@type"] == "textEntityTypeItalic" or entities[i].type["@type"] == "textEntityTypeCode" then
Type_Markdown = true
end
if entities[i].type["@type"] == "textEntityTypeUrl" or entities[i].type["@type"] == "textEntityTypeEmail" or entities[i].type["@type"] == "textEntityTypeTextUrl" then
Type_WebPage = true
end
if entities[i].type["@type"] == "textEntityTypeMentionName" then
Type_Mention = true
end
end
end
end
end
end
if Msg_Type == "Photo" or Msg_Type == "Video" or Msg_Type == "Audio" or Msg_Type == "Document" or Msg_Type == "Gif" or Msg_Type == "Voice" then
if msg.content.caption.entities then
if msg.content.caption.entities[0] then
local entities = msg.content.caption.entities
for i=0,#entities do
if entities[i]["@type"] == "textEntity" then
if entities[i].type["@type"] == "textEntityTypeBold" or entities[i].type["@type"] == "textEntityTypeItalic" or entities[i].type["@type"] == "textEntityTypeCode" then
Type_Markdown = true
end
if entities[i].type["@type"] == "textEntityTypeUrl" or entities[i].type["@type"] == "textEntityTypeEmail" or entities[i].type["@type"] == "textEntityTypeTextUrl" then
Type_WebPage = true
end
if entities[i].type["@type"] == "textEntityTypeMentionName" then
Type_Mention = true
end
end
end
end
end
end
end
if msg.forward_info then
if msg.forward_info["@type"] == "messageForwardedFromUser" or msg.forward_info["@type"] == "messageForwardedPost" then
Type_Forward = true
end
end
if msg.reply_markup and msg.reply_markup["@type"] == "replyMarkupInlineKeyboard" then
Type_Inline = true
end
if msg.reply_to_message_id ~= 0 then
Type_Reply = true
end
--Old Message
if tonumber(msg.date) < tonumber(os.time() - 900) then
return false
end
--If Message Is From Telegram Send The Code To Full Admin
if tonumber(msg.sender_user_id) == 777000 then
local Text = RemoveNumbers(msg.content.text.text)
SendAction(DataBase:get(BaseHash.."FullAdmin"),"Typing",100,Dl_Cb,data)
SendText(DataBase:get(BaseHash.."FullAdmin"),0,Text,Dl_Cb,data)
end
--AutoLeave From NormalGroups
if Place == "NormalGroup" then
SetChatMemberStatus(msg.chat_id,BOTID,"Left",1,Dl_Cb,data)
end
--View Messages If MarkRead Is On
if DataBase:get(BaseHash.."MarkRead") then
ViewMessages(msg.chat_id,{[0] = msg.id},Dl_Cb,data)
end
--Join Message If Its On
if Place == "Private" then
if not Admin(msg) and not Bot(msg) then
if DataBase:get(BaseHash.."SwitchJoinMessage") then
local JoinMessage = DataBase:get(BaseHash.."JoinMessage") or "سلام گلم وقت بخیر 🤦‍♀\nتو این پیج عضو شدی  " ..ChannelAddress.. "  بهم بگو شماره بدم تلفنی حرف بزنیم"
if not DataBase:sismember(BaseHash.."IgnoredJoin",msg.chat_id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,0,JoinMessage,Dl_Cb,data)
DataBase:sadd(BaseHash.."IgnoredJoin",msg.chat_id)
end
end
end
end
if Place == "SuperGroup" then
if DataBase:get(BaseHash.."AutoShare") then
if not DataBase:get(BaseHash.."AutoShareTime"..msg.chat_id) then
local function GetBotPhone(extra,result)
BotPhoneNumber = result.phone_number
BotFirstName = result.first_name
BotLastName = result.last_name
SendContact(msg.chat_id,0,true,true,nil,BotPhoneNumber,BotFirstName,BotLastName,result.id,callback,data)
end
GetUser(BOTID,GetBotPhone,data)
DataBase:setex(BaseHash.."AutoShareTime"..msg.chat_id,3600,true)
end
end
end
if Msg_Type == "Text" then
--Shorted msg.content.text.text to text
local text = msg.content.text.text
--Auto Save Links
if DataBase:get(BaseHash.."AutoJoin") then
if DataBase:get(BaseHash.."AutoJoinStatus") == "Admins" then
if Admin(msg) then
SaveLinks(text)
end
elseif DataBase:get(BaseHash.."AutoJoinStatus") == "All" or not DataBase:get(BaseHash.."AutoJoinStatus") then
SaveLinks(text)
end
end
--Kia Pashang Message
if Kia(msg) then
if text:match("^()$") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"ESETAdvertiser Source Version 3\nCreator : @To_My_Amigos\nChannel : @ESETAdvertiser",Dl_Cb,data)
end
end
--Full Admin Message
if Leader(msg) then
--Full Admin Help
if text:match("^(راهنمای سودو)$") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,FullAdminHelp,Dl_Cb,data)
end
--Reload
if text:match("^(ریلود)$") then
Reload()
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"ربات بازنگری شد",Dl_Cb,data)
end
--Reset Redis And Bot Settings
if text:match("^(بازنشانی) (.*)$") then
local matches = {string.match(text,"^(بازنشانی) (.*)$")}
if matches[2] == "همه" then
DataBase:del(BaseHash.."TimeCleanCache")
DataBase:del(BaseHash.."Id")
DataBase:del(BaseHash.."FirstName")
DataBase:del(BaseHash.."LastName")
DataBase:del(BaseHash.."PhoneNumber")
DataBase:del(BaseHash.."GoodLinks")
DataBase:del(BaseHash.."WaitLinks")
DataBase:del(BaseHash.."JunkLinks")
DataBase:del(BaseHash.."JoinedLinks")
DataBase:del(BaseHash.."Admins")
DataBase:del(BaseHash.."All")
DataBase:del(BaseHash.."Privates")
DataBase:del(BaseHash.."SuperGroups")
DataBase:del(BaseHash.."AutoJoin")
DataBase:del(BaseHash.."AutoJoinStatus")
DataBase:del(BaseHash.."AutoJoinTime")
DataBase:del(BaseHash.."AutoCheckTime")
DataBase:del(BaseHash.."MarkRead")
DataBase:del(BaseHash.."IgnoredJoin")
DataBase:del(BaseHash.."SwitchJoinMessage")
DataBase:del(BaseHash.."JoinMessage")
DataBase:del(BaseHash.."TimeLeaveChannels")
DataBase:del(BaseHash.."SwitchTimeForward")
DataBase:del(BaseHash.."TimeForwardStatus")
DataBase:del(BaseHash.."TimesToTimeForward")
DataBase:del(BaseHash.."NotSendTimeForward")
DataBase:del(BaseHash.."TimesForTimeForward")
DataBase:del(BaseHash.."TtlToTimeForward")
DataBase:del(BaseHash.."ManagerSuperGroup")
DataBase:del(BaseHash.."AddTimeContact")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"اطلاعات ربات بصورت کلی پاکسازی شد",Dl_Cb,data)
elseif matches[2] == "تنظیمات" then
DataBase:set(BaseHash.."MarkRead",true)
DataBase:set(BaseHash.."AutoJoin",true)
DataBase:set(BaseHash.."AutoJoinStatus","Admins")
DataBase:set(BaseHash.."SwitchJoinMessage",true)
DataBase:set(BaseHash.."TimeForwardStatus","SuperGroups")
DataBase:del(BaseHash.."JoinMessage")
DataBase:del(BaseHash.."IgnoredJoin")
DataBase:del(BaseHash.."TimeCleanCache")
DataBase:del(BaseHash.."Id")
DataBase:del(BaseHash.."FirstName")
DataBase:del(BaseHash.."LastName")
DataBase:del(BaseHash.."PhoneNumber")
DataBase:del(BaseHash.."Admins")
DataBase:del(BaseHash.."TimeLeaveChannels")
DataBase:del(BaseHash.."SwitchTimeForward")
DataBase:del(BaseHash.."TimesToTimeForward")
DataBase:del(BaseHash.."NotSendTimeForward")
DataBase:del(BaseHash.."TimesForTimeForward")
DataBase:del(BaseHash.."TtlToTimeForward")
DataBase:del(BaseHash.."AddTimeContact")
GetBot()
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id," تنظیمات ربات بازنشانی شد",Dl_Cb,data)
elseif matches[2] == "کلی" then
DataBase:set(BaseHash.."MarkRead",true)
DataBase:set(BaseHash.."AutoJoin",true)
DataBase:set(BaseHash.."AutoJoinStatus","Admins")
DataBase:set(BaseHash.."SwitchJoinMessage",true)
DataBase:del(BaseHash.."JoinMessage")
DataBase:del(BaseHash.."IgnoredJoin")
DataBase:del(BaseHash.."All")
DataBase:del(BaseHash.."Privates")
DataBase:del(BaseHash.."SuperGroups")
DataBase:del(BaseHash.."JunkLinks")
DataBase:del(BaseHash.."JoinedLinks")
DataBase:del(BaseHash.."Id")
DataBase:del(BaseHash.."FirstName")
DataBase:del(BaseHash.."LastName")
DataBase:del(BaseHash.."PhoneNumber")
DataBase:del(BaseHash.."SwitchTimeForward")
DataBase:del(BaseHash.."TimeForwardStatus")
DataBase:del(BaseHash.."TimesToTimeForward")
DataBase:del(BaseHash.."NotSendTimeForward")
DataBase:del(BaseHash.."TimesForTimeForward")
DataBase:del(BaseHash.."TtlToTimeForward")
DataBase:del(BaseHash.."AddTimeContact")
DataBase:del(BaseHash.."TimeLeaveChannels")
GetBot()
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id," ربات بازنشانی شد",Dl_Cb,data)
end
end
--Change Name
if text:match("^(تنظیم اسم) (.*)") then
local matches = {string.match(text,"^(تنظیم اسم) (.*)")}
if #matches == 2 then
SetName(matches[2],"",callback,data)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"اسم ربات به ["..matches[2].. "] تغییر یافت",Dl_Cb,data)
end
end
--Change Bio
if text:match("^(تنظیم درباره) (.*)") then
local matches = {string.match(text,"^(تنظیم درباره) (.*)")}
local Nl,CtrlChars = string.gsub(text,"%c","")
local Nl,RealDigits = string.gsub(text,"%d","")
if #matches == 2 then
if CtrlChars > 70 or RealDigits > 70 then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"درباره نباید بیشتر  از هفتاد کاراکتر تنظیم شود ",Dl_Cb,data)
else
SetBio(matches[2],callback,data)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"درباره ربات به ["  ..matches[2].. "] تغییر یافت",Dl_Cb,data)
end
end
end
--Change Profile Photo
if text:match("^(تنظیم تصویر)$") then
if Type_Reply then
local Id = msg.reply_to_message_id


SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,Id,"تصویر جدید با موفقیت تنظیم شد",Dl_Cb,data)
end
end
--Add An User To Bots Admin List
if text:match("^(افزودن مدیر) (.*)$") then
if Type_Mention then
local function promote_by_men(extra,result)
if result.id then
if tonumber(result.id) == BOTID then
return false
end
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
if DataBase:sismember(BaseHash.."Admins",result.id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"کاربر مورد نظر از قبلا مدیر میباشد",8,string.len(tp),result.id,Dl_Cb,data)
else
DataBase:sadd(BaseHash.."Admins",result.id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"کاربر مورد نظر با موفقیت به لیست مدیرهای ربات افزوده شد",8,string.len(tp),result.id,Dl_Cb,data)
end
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"کاربر مورد نظر یافت نشد",Dl_Cb,data)
end
end
GetUser(msg.content.text.entities[0].type.user_id,promote_by_men,data)
end
end
if text:match("^(افزودن مدیر)$") then
if Type_Reply then
local function promote_by_reply_one(extra,result)
local function promote_by_reply(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
if result.id then
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
if DataBase:sismember(BaseHash.."Admins",result.id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"کاربر مورد نظر از قبلا مدیر میباشد",8,string.len(tp),result.id,Dl_Cb,data)
else
DataBase:sadd(BaseHash.."Admins",result.id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id, msg.id,"کاربر مورد نظر با موفقیت به لیست مدیرهای ربات افزوده شد",8,string.len(tp),result.id,Dl_Cb,data)
end
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"کاربر مورد نظر یافت نشد",Dl_Cb,data)
end
end
GetUser(result.sender_user_id,promote_by_reply,data)
end
GetMessage(msg.chat_id,msg.reply_to_message_id,promote_by_reply_one,data)
end
end
if text:match("^(افزودن مدیر) @(%S+)$") then
local matches = {string.match(text,"^(افزودن مدیر) @(%S+)$")}
local function promote_by_username_one(extra,result)
local function promote_by_username(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
if DataBase:sismember(BaseHash.."Admins",result.id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"کاربر مورد نظر از قبلا مدیر میباشد",8,string.len(tp),result.id,Dl_Cb,data)
else
DataBase:sadd(BaseHash.."Admins",result.id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id, msg.id,"کاربر مورد نظر  با موفقیت به لیست مدیرهای ربات افزوده شد",8,string.len(tp),result.id,Dl_Cb,data)
end
end
if result.id then
GetUser(result.id,promote_by_username,data)
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"کاربر مورد نظر یافت نشد",Dl_Cb,data)
end
end
SearchPublicChat(matches[2],promote_by_username_one,data)
end
if text:match("^(افزودن مدیر) (%d+)$") then
local matches = {string.match(text,"^(افزودن مدیر) (%d+)$")}
local function promote_by_id(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
if result.id then
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
if DataBase:sismember(BaseHash.."Admins",result.id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"کاربر مورد نظر از قبل مدیر میباشد",8,string.len(tp),result.id,Dl_Cb,data)
else
DataBase:sadd(BaseHash.."Admins",result.id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id, msg.id,"کاربر مورد نظر با موفقیت به لیست مدیرهای ربات افزوده شد",8,string.len(tp),result.id,Dl_Cb,data)
end
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"کاربر مورد نظر یافت نشد",Dl_Cb,data)
end
end
GetUser(matches[2],promote_by_id,data)
end
--Remove An User From Bots Admin List
if text:match("^(حذف مدیر) (.*)$") then
if Type_Mention then
local function demote_by_men(extra,result)
if result.id then
if tonumber(result.id) == BOTID then
return false
end
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
if not DataBase:sismember(BaseHash.."Admins",result.id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"کاربر مورد نظر مدیر نمیباشد",8,string.len(tp),result.id,Dl_Cb,data)
else
DataBase:srem(BaseHash.."Admins",result.id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"کاربر مورد نظر با موفقیت از لیست مدیرهای ربات حذف شد",8,string.len(tp),result.id,Dl_Cb,data)
end
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"کاربر مورد نظر یافت نشد",Dl_Cb,data)
end
end
GetUser(msg.content.text.entities[0].type.user_id,demote_by_men,data)
end
end
if text:match("^(حذف مدیر)$") then
if Type_Reply then
local function demote_by_reply_one(extra,result)
local function demote_by_reply(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
if result.id then
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
if not DataBase:sismember(BaseHash.."Admins",result.id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id, msg.id,"کاربر مورد نظر مدیر نمیباشد",8,string.len(tp),result.id,Dl_Cb,data)
else
DataBase:srem(BaseHash.."Admins",result.id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id," کاربر مورد نظر با موفقیت از لیست مدیرهای ربات حذف شد",8,string.len(tp),result.id,Dl_Cb,data)
end
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"کاربر مورد نظر یافت نشد",Dl_Cb,data)
end
end
GetUser(result.sender_user_id,demote_by_reply,data)
end
GetMessage(msg.chat_id,msg.reply_to_message_id,demote_by_reply_one,data)
end
end
if text:match("^(حذف مدیر) @(%S+)$") then
local matches = {string.match(text,"^(حذف مدیر) @(%S+)$")}
local function demote_by_username_one(extra,result)
local function demote_by_username(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
if not DataBase:sismember(BaseHash.."Admins",result.id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id, msg.id,"کاربر مورد نظر مدیر نمیباشد",8,string.len(tp),result.id,Dl_Cb,data)
else
DataBase:srem(BaseHash.."Admins",result.id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id, msg.id,"کاربر مورد نظر با موفقیت از لیست مدیرهای حذف شد",8,string.len(tp),result.id,Dl_Cb,data)
end
end
if result.id then
GetUser(result.id,demote_by_username,data)
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"کاربر مورد نظر یافت نشد",Dl_Cb,data)
end
end
SearchPublicChat(matches[2],demote_by_username_one,data)
end
if text:match("^(حذف مدیر) (%d+)$") then
local matches = {string.match(text,"^(حذف مدیر) (%d+)$")}
local function demote_by_id(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
if result.id then
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
if not DataBase:sismember(BaseHash.."Admins",result.id) then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"کاربر مورد نظر مدیر نمیباشد",8,string.len(tp),result.id,Dl_Cb,data)
else
DataBase:srem(BaseHash.."Admins",result.id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id," کاربر مورد نظر با موفقیت از لیست مدیرهای ربات حذف شد ",8,string.len(tp),result.id,Dl_Cb,data)
end
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"کاربر مورد نظر یافت نشد",Dl_Cb,data)
end
end
GetUser(matches[2],demote_by_id,data)
end
--Bot Admins List
if text:match("^(لیست مدیران)$") then
local Admins = DataBase:smembers(BaseHash.."Admins")
local Text = "لیست مدیرهای ربات به شرح زیر است !\n\n"
s = 1
for i, v in pairs(Admins) do
if not tostring(v):match("-") then
Text = ""..Text..""..s..". "..tostring(v).."\n"
s = s + 1
end
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,Text,Dl_Cb,data)
end
--Clean Bot Admins List
if text:match("^(پاکسازی لیست مدیران)$") then
if not DataBase:smembers(BaseHash.."Admins") then
SendText(msg.chat_id,msg.id,"لیست مدیرهای ربات خالی میباشد",Dl_Cb,data)
else
DataBase:del(BaseHash.."Admins")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"لیست مدیرهای ربات با موفقیت خالی شد",Dl_Cb,data)
end
end
--Only In SuperGroup
if Place == "SuperGroup" then
--Add Support SuperGroup
if text:match("^(تنظیم گروه مدیریت)$") then
DataBase:del(BaseHash.."ManagerSuperGroup")
DataBase:set(BaseHash.."ManagerSuperGroup",msg.chat_id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"دستور شما با موفقیت انجام شد",Dl_Cb,data)
end
--Remove Support SuperGroup
if text:match("^(حذف گروه مدیریت)$") then
DataBase:del(BaseHash.."ManagerSuperGroup")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"گروه فعلی دیگر سوپرگروه مدیریت نمیباشد",Dl_Cb,data)
end
end
if text:match("^(پاکسازی گروه مدیریت)$") then
DataBase:del(BaseHash.."ManagerSuperGroup")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"گروه با موفقیت  پاکسازی شد",Dl_Cb,data)
end
end
--Admin Message
if Admin(msg) then
--Cancel Operation Of Adding Time Contatcs
if DataBase:get(BaseHash.."AddTimeContact"..msg.chat_id) then
if text:match("^(لغو)$") then
DataBase:del(BaseHash.."AddTimeContact"..msg.chat_id)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• عملیات افزودن مخاطبین برای سوپرگروه فعلی لغو شد.",Dl_Cb,data)
end
end
--See If Bot Is Online
if text:match("^(انلاینی)$") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"> ربات تبچی اماده به کار میباشد 😎",Dl_Cb,data)
end
--See If Bot Is Limited For Chatting And Its Online
if text:match("^(انلاین)$") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
Forward(msg.chat_id,msg.chat_id,{[0] = msg.id},0,1,Dl_Cb,data)
end
--Main Help
if text:match("^(راهنما)$") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,MainText,Dl_Cb,data)
end
--General Help
if text:match("^(راهنمای اصلی)$") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,GeneralHelp,Dl_Cb,data)
end
--Timr Forward Help
if text:match("^()$") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,TimeForwardHelp,Dl_Cb,data)
end
--Bot Phone Number
if text:match("^(شماره ربات)$") then
local function GetBotPhone(extra,result)
BotPhoneNumber = result.phone_number
BotFirstName = result.first_name
BotLastName = result.last_name
SendContact(msg.chat_id,msg.id,true,true,nil,BotPhoneNumber,BotFirstName,BotLastName,result.id,callback,data)
end
GetUser(BOTID,GetBotPhone,data)
end
--Leave This SuperGroup
if text:match("^(ترک سوپرگروه)$") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
Rem(msg.chat_id)
SetChatMemberStatus(msg.chat_id,BOTID,"Left",1,Dl_Cb,data)
end
--Delete All Chats
if text:match("^(پاکسازی نمایه ربات)$") then
local SuperGroups = DataBase:smembers(BaseHash.."SuperGroups")
local function GetAllChats(extra,result)
local Chats = result.chat_ids or {}
if #Chats ~= 0 then
for i=0,#Chats do
DeleteChats(Chats[i],true,Dl_Cb,data)
end
end
end
GetChats("9223372036854775807",0,99999,GetAllChats,data)
local function GetSuperGroups(extra,result)
local Chats = result.chat_ids or {}
if #Chats ~= 0 then
for i=0,#Chats do
if tostring(Chats[i]):match("-100(%d+)") then
function CheckChannels(extra,result)
if (result.type["@type"] == "chatTypeSupergroup") then
SetChatMemberStatus(extra.id,BOTID,"Left",1,Dl_Cb,data)
Rem(extra.id)
end
end
GetChat(Chats[i],CheckChannels,{id = Chats[i]})
end
end
end
end
GetChats("9223372036854775807",0,99999,GetSuperGroups,data)
for i=1,#SuperGroups do
SetChatMemberStatus(SuperGroups[i],BOTID,"Left",1,Dl_Cb,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• نمایه ربات شماره "..Advertiser_Id.." پاکسازی شذ.",Dl_Cb,data)
DataBase:del(BaseHash.."All")
DataBase:del(BaseHash.."Privates")
DataBase:del(BaseHash.."SuperGroups")
end
--Leave All SuperGroups
if text:match("^(ترک همه)$") then
local SuperGroups = DataBase:smembers(BaseHash.."SuperGroups")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ربات از همه سوپرگروه ها خارج خواهد شد اگر قصد تخلیه سوپرگروه ها را دارید لطفا عضویت خودکار را خاموش کنید و عملیات خروج از سوپرگروه ها ممکن است چند دقیقه طول بکشد.",Dl_Cb,data)
for i=1,#SuperGroups do
SetChatMemberStatus(SuperGroups[i],BOTID,"Left",1,Dl_Cb,data)
end
DataBase:del(BaseHash.."SuperGroups")
end
--Turn On/Off Auto Join
if text:match("^(عضویت خودکار) (.*)$") then
local matches = {string.match(text,"^(عضویت خودکار) (.*)$")}
if matches[2] == "روشن" then
if DataBase:get(BaseHash.."AutoJoin") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• عضویت خودکار از قبل روشن است.",Dl_Cb,data)
else
DataBase:set(BaseHash.."AutoJoin",true)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• عضویت خودکار روشن شد.",Dl_Cb,data)
end
elseif matches[2] == "خاموش" then
if not DataBase:get(BaseHash.."AutoJoin") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• عضویت خودکار از قبل خاموش است.",Dl_Cb,data)
else
DataBase:del(BaseHash.."AutoJoin")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• عضویت خودکار خاموش شد.",Dl_Cb,data)
end
end
end
--Set Status For Auto Join
if text:match("^(ذخیره لینک از) (.*)$") then
local matches = {string.match(text,"^(ذخیره لینک از) (.*)$")}
if #matches == 2 then
if matches[2] == "همه" then
DataBase:set(BaseHash.."AutoJoinStatus","All")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• وضعیت ذخیره لینک تنظیم شد به ذخیره لینک از همه.",Dl_Cb,data)
elseif matches[2] == "مدیران" then
DataBase:del(BaseHash.."AutoJoinStatus")
DataBase:set(BaseHash.."AutoJoinStatus","Admins")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• وضعیت ذخیره لینک تنظیم شد به ذخیره لینک از مدیر ها.",Dl_Cb,data)
end
end
end
--Save Contact
if text:match("^(ذخیره مخاطب)$") then
DataBase:setex(BaseHash.."AddTimeContact"..msg.chat_id,30,true)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ذخیره مخاطب برای سی ثانیه برای گفتوگوی فعلی فعال شد,در این بازه زمانی هر شماره ای در گفتوگوی فعلی فرستاده شود,توسط ربات ذخیره خواهد شد در صورت لغو عملیات دستور لغو را بفرستید\nلطفا شماره هایی که میخواهید ذخیره شود را به اشتراک بگذارید.",Dl_Cb,data)
end
--Add Contacts In SuperGroup
if text:match("^(افزودن مخاطبین)$") then
local Privates = DataBase:smembers(BaseHash.."Privates")
for i=1,#Privates do
AddChatMember(msg.chat_id,Privates[i],50,Dl_Cb,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• درحال افزودن کاربرها به سوپرگروه ...",Dl_Cb,data)
end
--Clean Saved Links
if text:match("^(پاکسازی لینک ها)$") then
DataBase:del(BaseHash.."GoodLinks")
DataBase:del(BaseHash.."WaitLinks")
DataBase:del(BaseHash.."JunkLinks")
DataBase:del(BaseHash.."JoinedLinks")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• لیست لینک های ذخیره شده پاکسازی شد.",Dl_Cb,data)
end
--Turn On/Off Join Message
if text:match("^(پیام عضویت) (.*)$") then
local matches = {string.match(text,"^(پیام عضویت) (.*)$")}
if matches[2] == "روشن" then
if DataBase:get(BaseHash.."SwitchJoinMessage") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• پیام عضویت از قبل روشن است.",Dl_Cb,data)
else
DataBase:set(BaseHash.."SwitchJoinMessage",true)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• پیام عضویت روشن شد.",Dl_Cb,data)
end
elseif matches[2] == "خاموش" then
if not DataBase:get(BaseHash.."SwitchJoinMessage") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• پیام عضویت از قبل خاموش است.",Dl_Cb,data)
else
DataBase:del(BaseHash.."SwitchJoinMessage")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• پیام عضویت خاموش شد.",Dl_Cb,data)
end
end
end
--Set Join Message
if text:match("^(تنظیم پیام عضویت) (.*)") then
local matches = {string.match(text,"^(تنظیم پیام عضویت) (.*)")}
if #matches == 2 then
DataBase:del(BaseHash.."JoinMessage")
DataBase:set(BaseHash.."JoinMessage",matches[2])
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• پیام عضویت به :\n\n"..matches[2].."\n\nتنظیم شد.",Dl_Cb,data)
end
end
--Turn On/Off MarkRead
if text:match("^(خواندن پیام) (.*)$") then
local matches = {string.match(text,"^(خواندن پیام) (.*)$")}
if matches[2] == "روشن" then
if DataBase:get(BaseHash.."MarkRead") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• حالت خواندن پیام از قبل روشن است.",Dl_Cb,data)
else
DataBase:set(BaseHash.."MarkRead",true)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• حالت خواندن پیام روشن شد.",Dl_Cb,data)
end
elseif matches[2] == "خاموش" then
if not DataBase:get(BaseHash.."MarkRead") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• حالت خواندن پیام از قبل خاموش است.",Dl_Cb,data)
else
DataBase:del(BaseHash.."MarkRead")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• حالت خواندن پیام خاموش شد.",Dl_Cb,data)
end
end
end
--Forward The Replyed Message To Privates/SuperGroups/All
if text:match("^(ارسال به) (.*)$") then
if msg.reply_to_message_id ~=0 then
local matches = {string.match(text,"^(ارسال به) (.*)$")}
local Id = msg.reply_to_message_id
local Privates,SuperGroups,All = DataBase:smembers(BaseHash.."Privates"),DataBase:smembers(BaseHash.."SuperGroups"),DataBase:smembers(BaseHash.."All")
if matches[2] == "همه" then
for i=1,#All do
Forward(All[i],msg.chat_id,{[0] = Id},0,1,Dl_Cb,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال شد به همه.",Dl_Cb,data)
end
if matches[2] == "کاربران" then
for i=1,#Privates do
Forward(Privates[i],msg.chat_id,{[0] = Id},0,1,Dl_Cb,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال شد به خصوصی ها.",Dl_Cb,data)
end
if matches[2] == "سوپرگروه ها" then
for i=1,#SuperGroups do
Forward(SuperGroups[i],msg.chat_id,{[0] = Id},0,1,Dl_Cb,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال شد به سوپرگروه ها.",Dl_Cb,data)
end
end
end
--Turn On/Off Time Forward
if text:match("^(ارسال زماندار خودکار) (.*)$") then
local matches = {string.match(text,"^(ارسال زماندار خودکار) (.*)$")}
if matches[2] == "روشن" then
if DataBase:get(BaseHash.."SwitchTimeForward") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال زماندار خودکار از قبل روشن است.",Dl_Cb,data)
else
DataBase:set(BaseHash.."SwitchTimeForward",true)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال زماندار خودکار روشن شد.",Dl_Cb,data)
end
elseif matches[2] == "خاموش" then
if not DataBase:get(BaseHash.."SwitchTimeForward") then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال زماندار خودکار از قبل خاموش است.",Dl_Cb,data)
else
DataBase:del(BaseHash.."SwitchTimeForward")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال زماندار خودکار خاموش شد.",Dl_Cb,data)
end
end
end
--Set Time Forward
if text:match("^(تنظیم ارسال زماندار خودکار) (%d+) (%d+)$") then
if Type_Reply then
local matches = {string.match(text,"^(تنظیم ارسال زماندار خودکار) (%d+) (%d+)$")}
if #matches == 3 and tonumber(matches[2]) then
local time = tonumber(matches[2]) * 60
local TimeToSendTimeForward = tonumber(matches[3])
local Id = msg.reply_to_message_id
DataBase:setex(BaseHash.."NotSendTimeForward"..Id,time,true)
DataBase:set(BaseHash.."TimesForTimeForward"..Id,TimeToSendTimeForward)
DataBase:sadd(BaseHash.."TimesToTimeForward",Id)
DataBase:set(BaseHash.."FromChatIdToTimeForward"..Id,msg.chat_id)
DataBase:set(BaseHash.."TtlToTimeForward"..Id,time)
if DataBase:get(BaseHash.."SwitchTimeForward") then
TimeForwardText = "• این پست هر "..matches[2].." دقیقه یک بار ارسال میشود و این عمل برای "..matches[3].." بار تکرار میشود\nشناسه ارسال زماندار خودکار : "..Id..""
else
DataBase:set(BaseHash.."SwitchTimeForward",true)
TimeForwardText = "• ارسال زماندار خودکار روشن شد و این پست هر "..matches[2].." دقیقه یک بار ارسال میشود و این عمل برای "..matches[3].." بار تکرار میشود\nشناسه ارسال زماندار خودکار : "..Id..""
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,TimeForwardText,Dl_Cb,data)
end
end
end
if text:match("^(حذف ارسال زماندار خودکار) (%d+)$") then
local matches = {string.match(text,"^(حذف ارسال زماندار خودکار) (%d+)$")}
if #matches == 2 then
if DataBase:sismember(BaseHash.."TimesToTimeForward",matches[2]) then
DataBase:srem(BaseHash.."TimesToTimeForward",matches[2])
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال زماندار خودکار با شناسه "..matches[2].." حذف شد.",Dl_Cb,data)
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال زماندار خودکار یافت نشد.",Dl_Cb,data)
end
end
end
--Send The Time Forward
if text:match("^(دریافت ارسال زماندار خودکار) (%d+)$") then
local matches = {string.match(text,"^(دریافت ارسال زماندار خودکار) (%d+)$")}
if #matches == 2 then
if DataBase:get(BaseHash.."FromChatIdToTimeForward"..matches[2]) then
Forward(msg.chat_id,DataBase:get(BaseHash.."FromChatIdToTimeForward"..matches[2]),{[0] = tonumber(matches[2])},0,1,Dl_Cb,data)
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• ارسال زماندار خودکار یافت نشد.",Dl_Cb,data)
end
end
end
--Set Status For Time Forward
if text:match("^(ارسال زماندار خودکار به) (.*)$") then
local matches = {string.match(text,"^(ارسال زماندار خودکار به) (.*)$")}
if #matches == 2 then
if matches[2] == "همه" then
DataBase:del(BaseHash.."TimeForwardStatus")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• وضعیت ارسال زماندار خودکار تنظیم شد به همه.",Dl_Cb,data)
elseif matches[2] == "سوپرگروه ها" then
DataBase:del(BaseHash.."TimeForwardStatus")
DataBase:set(BaseHash.."TimeForwardStatus","SuperGroups")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• وضعیت ارسال زماندار خودکار تنظیم شد به سوپرگروه ها.",Dl_Cb,data)
elseif matches[2] == "کاربران" then
DataBase:del(BaseHash.."TimeForwardStatus")
DataBase:set(BaseHash.."TimeForwardStatus","Privates")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• وضعیت ارسال زماندار خودکار تنظیم شد به کاربران.",Dl_Cb,data)
end
end
end
--Time Forward List
if text:match("^(لیست ارسال زماندار خودکار)$") then
local All = DataBase:smembers(BaseHash.."TimesToTimeForward")
local Text = "• لیست ارسال زماندار خودکار : \n\n"
for i = 1, #All do
Text = Text .. i .. ". شناسه : " .. All[i] .. ", هر " .. DataBase:get(BaseHash.."TtlToTimeForward"..All[i]) / 60 .. " دقیقه یک بار ارسال میشود و این عمل " .. DataBase:get(BaseHash.."TimesForTimeForward"..All[i]) .. " بار تکرار میشود."
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,Text,Dl_Cb,data)
end
--Clean Time Forward List
if text:match("^(پاکسازی لیست ارسال زماندار خودکار)$") then
DataBase:del(BaseHash.."NotSendTimeForward")
DataBase:del(BaseHash.."TimesForTimeForward")
DataBase:del(BaseHash.."TimesToTimeForward")
DataBase:del(BaseHash.."FromChatIdToTimeForward")
DataBase:del(BaseHash.."TtlToTimeForward")
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• لیست ارسال زماندار خودکار پاکسازی شد.",Dl_Cb,data)
end
--Add An User To All SuperGroups
if text:match("^(افزودن به همه) (.*)$") then
if Type_Mention then
local SuperGroups = DataBase:smembers(BaseHash.."SuperGroups")
local function addtoall_by_men(extra,result)
if result.id then
if tonumber(result.id) == BOTID then
return false
end
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
for i=1,#SuperGroups do
AddChatMember(SuperGroups[i],result.id,50,callback,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"• کاربر "..tp.." به همه سوپرگروه ها افزوده شد.",8,string.len(tp),result.id,Dl_Cb,data)
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• کاربر بافت نشد.",Dl_Cb,data)
end
end
GetUser(msg.content.text.entities[0].type.user_id,addtoall_by_men,data)
end
end
if text:match("^(افزودن به همه)$") then
if Type_Reply then
local SuperGroups = DataBase:smembers(BaseHash.."SuperGroups")
local function addtoall_by_reply_one(extra,result)
local function addtoall_by_reply(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
if result.id then
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
for i=1,#SuperGroups do
AddChatMember(SuperGroups[i],result.id,50,callback,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"• کاربر "..tp.." به همه سوپرگروه ها افزوده شد.",8,string.len(tp),result.id,Dl_Cb,data)
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• کاربر بافت نشد.",Dl_Cb,data)
end
end
GetUser(result.sender_user_id,addtoall_by_reply,data)
end
GetMessage(msg.chat_id,msg.reply_to_message_id,addtoall_by_reply_one,data)
end
end
if text:match("^(افزودن به همه) @(%S+)$") then
local matches = {string.match(text,"^(افزودن به همه) @(%S+)$")}
local SuperGroups = DataBase:smembers(BaseHash.."SuperGroups")
local function addtoall_by_username_one(extra,result)
local function addtoall_by_username(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
for i=1,#SuperGroups do
AddChatMember(SuperGroups[i],result.id,50,callback,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"• کاربر "..tp.." به همه سوپرگروه ها افزوده شد.",8,string.len(tp),result.id,Dl_Cb,data)
end
if result.id then
GetUser(result.id,addtoall_by_username,data)
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• کاربر بافت نشد.",Dl_Cb,data)
end
end
SearchPublicChat(matches[2],addtoall_by_username_one,data)
end
if text:match("^(افزودن به همه) (%d+)$") then
local matches = {string.match(text,"^(افزودن به همه) (%d+)$")}
local SuperGroups = DataBase:smembers(BaseHash.."SuperGroups")
local function addtoall_by_id(extra,result)
if result.id then
if tonumber(result.id) == tonumber(BOTID) then
return false
end
end
if result.id then
local tf = result.first_name or ""
local tl = result.last_name or ""
if string.len(result.username) > 4 then
tp = result.username
else
local st = tf.. " "..tl
if string.len(st) > 20 then
tp = result.id
else
if st:match("[A-Z]") or st:match("[a-z]") then
tp = st
else
tp = result.id
end
end
end
if not tp then
tp = result.id
end
for i=1,#SuperGroups do
AddChatMember(SuperGroups[i],result.id,50,callback,data)
end
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendMention(msg.chat_id,msg.id,"• کاربر "..tp.." به همه سوپرگروه ها افزوده شد.",8,string.len(tp),result.id,Dl_Cb,data)
else
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• کاربر بافت نشد.",Dl_Cb,data)
end
end
GetUser(matches[2],addtoall_by_id,data)
end
--Echo Text
if text:match("^(اکو) (.*)$") then
local matches = {string.match(text,"^(اکو) (.*)")}
if #matches == 2 then
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,0,matches[2],Dl_Cb,data)
end
end
--Bot Panel
if text:match("^(آمار)$") then
SearchContacts(tostring(""),99999,GetContacts,data)
local Privates = DataBase:scard(BaseHash.."Privates")
local SuperGroups = DataBase:scard(BaseHash.."SuperGroups")
local WaitLinks = DataBase:scard(BaseHash.."WaitLinks")
local JunkLinks = DataBase:scard(BaseHash.."JunkLinks")
local GoodLinks = DataBase:scard(BaseHash.."GoodLinks")
local JoinedLinks = DataBase:scard(BaseHash.."JoinedLinks")
local Text = "•• آمار ربات :\n\n• کاربر های خصوصی : "..tostring(Privates).."\n• سوپرگروه ها : "..tostring(SuperGroups).."\n••••••••••••••••••••\n• لینک های ذخیره شده : "..tostring(WaitLinks).."\n• لینک های سالم : "..tostring(GoodLinks).."\n• لینک های عضو شده : "..tostring(JoinedLinks).."\n• لینک های ناسالم : "..tostring(JunkLinks).."\n••••••••••••••••••••\n• سازنده : @accounSale\n• کانال : @accounSale"
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,Text,Dl_Cb,data)
end
--Bot Status
if text:match("^(تنظیمات)$") then
local ServerInformation = io.popen("~/KiaPashang/Launch Stats"):read("*all")
local AutoCheckTime = "0"
local AutoJoinTime = "0"
local TimeCleanCache = "0"
local TimeOpenChats = "0"
local TimeLeaveChannels = "0"
local JoinMessage = DataBase:get(BaseHash.."JoinMessage") or "سلام عزیز\nلطفا بیا توی کانالم "..ChannelAddress.."\nزود بیا فدات الان برمیگردم پیشت"
if DataBase:get(BaseHash.."MarkRead") then
MarkRead = "✅"
else
MarkRead = "❌"
end
if DataBase:get(BaseHash.."AutoJoin") then
AutoJoin = "✅"
else
AutoJoin = "❌"
end
if DataBase:get(BaseHash.."SwitchJoinMessage") then
SwitchJoinMessage = "✅"
else
SwitchJoinMessage = "❌"
end
if DataBase:get(BaseHash.."SwitchTimeForward") then
SwitchTimeForward = "✅"
else
SwitchTimeForward = "❌"
end
if DataBase:get(BaseHash.."TimeForwardStatus") == "SuperGroups" then
TimeForwardStatus = "سوپرگروه ها"
elseif DataBase:get(BaseHash.."TimeForwardStatus") == "Privates" then
TimeForwardStatus = "کاربران"
elseif not DataBase:get(BaseHash.."TimeForwardStatus") then
TimeForwardStatus = "همه"
end
if DataBase:get(BaseHash.."AutoJoinStatus") == "All" or not DataBase:get(BaseHash.."AutoJoinStatus") then
AutoJoinStatus = "همه"
elseif DataBase:get(BaseHash.."AutoJoinStatus") == "Admins" then
AutoJoinStatus = "مدیران"
end
if DataBase:get(BaseHash.."AutoCheckTime") then
AutoCheckTime = DataBase:ttl(BaseHash.."AutoCheckTime")
end
if DataBase:get(BaseHash.."AutoJoinTime") then
AutoJoinTime = DataBase:ttl(BaseHash.."AutoJoinTime")
end
if DataBase:get(BaseHash.."TimeCleanCache") then
TimeCleanCache = DataBase:ttl(BaseHash.."TimeCleanCache")
end
if DataBase:get(BaseHash.."TimeOpenChats") then
TimeOpenChats = DataBase:ttl(BaseHash.."TimeOpenChats")
end
if DataBase:get(BaseHash.."TimeLeaveChannels") then
TimeLeaveChannels = DataBase:ttl(BaseHash.."TimeLeaveChannels")
end
local Text = "•• تنظیمات ربات :\n\n• حالت خواندن پیام : "..MarkRead.."\n• عضویت خودکار : "..AutoJoin.."\n• وضعیت ذخیره لینک : از "..AutoJoinStatus.."\n••••••••••••••••••••\n• زمان باقی مانده برای تایید لینک جدید : "..AutoCheckTime.." ثانیه\n• زمان باقیمانده برای عضویت به لینک جدید : "..AutoJoinTime.." ثانیه\n••••••••••••••••••••\n• ارسال زماندار خودکار : "..SwitchTimeForward.."\n• وضعیت ارسال زماندار خودکار : ارسال به "..TimeForwardStatus.."\n••••••••••••••••••••\n• پیام عضویت : "..SwitchJoinMessage.."\n• متن پیام عضویت : "..JoinMessage.."\n••••••••••••••••••••\n• زمان پاک کردن کش ربات : "..TimeCleanCache.." ثانیه\n• زمان باقیمانده برای باز کردن گفتگو ها : "..TimeOpenChats.." ثانیه\n• زمان باقی مانده برای ترک کانال های افزوده شده : "..TimeLeaveChannels.." ثانیه\n••••••••••••••••••••\n"..ServerInformation.."••••••••••••••••••••\n• سازنده : @accounSale \n• کانال : @accounSale"
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,Text,Dl_Cb,data)
end
end
--For Adding Contacts
elseif Msg_Type == "Contact" then
--Shorted msg.content.contact to contact
contact = msg.content.contact
if contact then
--Save Time Add Contact
if not Bot(msg) then
if DataBase:get(BaseHash.."AddTimeContact"..msg.chat_id) then
ImportContact(contact.phone_number,contact.first_name or "-",contact.last_name or "-",contact.user_id,Dl_Cb,data)
SendAction(msg.chat_id,"Typing",100,Dl_Cb,data)
SendText(msg.chat_id,msg.id,"• مخاطب ذخیره شد.",Dl_Cb,data)
end
end
end
end
--#----------------------------------------#--
elseif (data["@type"] == "updateChatReadInbox") then
--#----------------------------------------#--
elseif (data["@type"] == "updateChannel") then
--#----------------------------------------#--
elseif (data["@type"] == "messageChatDeleteMember") then
--#----------------------------------------#--
elseif (data["@type"] == "updateMessageSendSucceeded") then
--#----------------------------------------#--
elseif (data["@type"] == "updateUserStatus") then
--#----------------------------------------#--
elseif (data["@type"] == "updateSupergroup") then
--Get Bot Id
local BOTID = tonumber(DataBase:get(BaseHash.."Id")) or GetBot()
--Remove The Removed SuperGroup ID From Redis
local function RemoveTheRemovedSuperGroupID(extra,result)
if extra.supergroup and extra.supergroup.sign_messages and extra.supergroup.status["@type"] == "chatMemberStatusBanned" then
local ChatID = "-100"..extra.supergroup.id
Rem(ChatID)
end
end
local SuperGroupID = "-100"..data.supergroup.id
GetChat(tonumber(SuperGroupID),RemoveTheRemovedSuperGroupID,data)
--Leave The Restricted SuperGroup
local function LeaveRestrictedSuperGroup(extra,result)
if extra.supergroup and extra.supergroup.status["@type"] == "chatMemberStatusRestricted" and not extra.supergroup.status.can_send_messages then
local ChatID = "-100"..extra.supergroup.id
Rem(ChatID)
SetChatMemberStatus(tonumber(ChatID),BOTID,"Left",1,Dl_Cb,data)
end
end
local SuperGroupID = "-100"..data.supergroup.id
GetChat(tonumber(SuperGroupID),LeaveRestrictedSuperGroup,data)
--#----------------------------------------#--
elseif (data["@type"] == "updateChat") then
--#----------------------------------------#--
elseif (data["@type"] == "updateDeleteMessages") then
--#----------------------------------------#--
elseif (data["@type"] == "updateChatLastMessage") then
--#----------------------------------------#--
elseif (data["@type"] == "updateUser") then
--#----------------------------------------#--
elseif (data["@type"] == "updateNewChat") then
--#----------------------------------------#--
elseif (data["@type"] == "updateChatTopMessage") then
--#----------------------------------------#--
elseif (data["@type"] == "updateOpenMessageContent") then
--#----------------------------------------#--
elseif (data["@type"] == "updateGroupFull") then
--#----------------------------------------#--
end
end
return {Update = Update}
