import 'package:greaticker/home/constants/project.dart';

const COMMENT_DICT= {
  "KO" : {
    "network_error" : "서버와의 통신에 실패하였습니다.",
    "delete_project_try" : "정말로 목표를 삭제하시겠습니까? 목표를 삭제하면 지금까지 모았던 스티커를 잃지만 새로운 목표를 생성할 수 있습니다.",
    "delete_project_complete" : "목표가 삭제되었습니다.",
    "create_project_try" : "새로운 목표의 이름을 입력해주세요.",
    "create_project_sticker_loss_notice" : "새로운 목표를 생성하시면 지금까지 모았던 스티커가 사라집니다. 새로운 목표를 생성하시겠습니까?",
    "create_project_complete" : "목표가 생성되었습니다! 30일동안 달성하시기를 응원합니다!",
    "complete_project_notice" : "목표를 달성하셨습니다. 축하드립니다. 새로운 목표를 생성하실 때까지 모았던 스티커가 유지됩니다.",
    "reset_project_notice" : "어제 목표를 달성하지 않아 해당 목표를 1일차 부터 다시 시작하게 되었습니다. ㅠㅠ",
    "confirm_before_got_sticker" : "오늘의 목표를 달성하셨나요? 달성하셨다면 스티커를 획득하세요!",
    "duplicated_nickname" : "중복된 닉네임입니다",
    "can_not_register_favorite_sticker_more_than_3" : "최애 스티커를 3개를 초과하여 등록할 수 없습니다.",
    "no_goal_set" : "목표 없음",
    "today_sticker_already_got" : "오늘의 스티커를 이미 획득하셨습니다.",
    "change_nickname_try" : "바꿀 닉네임을 입력해 주세요.",
    "change_nickname_completed" : "닉네임이 변경되었습니다.",
    "over_nickname_length" : "닉네임은 26Byte(한글 2Byte, 영대문자 1.5Byte, 공백과 영소문자 1Byte)를 넘을 수 없습니다.",
    "under_nickname_length" : "닉네임은 12Byte(한글 2Byte, 영대문자 1.5Byte, 공백과 영소문자 1Byte)이상이어야 합니다.",
    "log_out_complete" : "로그아웃이 완료되었습니다.",
    "delete_account_try" : "회원 탈퇴를 하시면 언제든지 재가입하실 수 있지만 지금까지 설정한 목표 정보와 모았던 스티커 정보가 삭제됩니다. 정말 회원 탈퇴를 하시겠습니까?",
    "delete_account_complete" : "회원 탈퇴가 완료되었습니다.",
    "choice_below" : "아래 사항들을 선택해 주세요.",
    "only_nickname" : "닉네임만 노출",
    "both_nickname_and_auth_id" : "닉네임과 아이디 노출",
    "register_hall_of_fame_complete" : "명예의 전당에 등록이 완료되었습니다.",
    "delete_hall_of_fame_complete" : "삭제가 완료되었습니다.",
    //"diary_sticker_order_update_try" : "변경된 스티커 순서를 저장하시겠습니까?",
    "duplicated_hall_of_fame" : "해당 목표를 이미 명예의 전당에 등록하셨습니다.",
    "not_allowed_character" : "특수문자를 포함하거나 User로 시작되는 닉네임은 허용되지 않습니다.",
    "over_project_name_length" : "프로젝트 이름은 26Byte(한글 2Byte, 영대문자 1.5Byte, 공백과 영소문자 1Byte)를 넘을 수 없습니다.",
    "under_project_name_length" : "프로젝트 이름은 6Byte(한글 2Byte, 영대문자 1.5Byte, 공백과 영소문자 1Byte)이상이어야 합니다.",
    "can_hit_favorite_to_sticker_after_got_all_sticker" : "모든 스티커를 모아야 최애 스티커를 지정할 수 있습니다.",
    "app_title" : "잘했스티커",
    "app_description" : "목표를 달성하고 모든 스티커를 모아보세요!",
  },
  "EN" : {
    "network_error": "Failed to communicate with the server.",
    "delete_project_try": "Are you sure you want to delete this goal? Deleting the goal will result in losing the stickers you've collected so far, but you can create a new goal.",
    "delete_project_complete": "The goal has been deleted.",
    "create_project_try": "Please enter the name of the new goal.",
    "create_project_sticker_loss_notice": "Creating a new goal will remove the stickers you've collected so far. Are you sure you want to create a new goal?",
    "create_project_complete": "A new goal has been created! We wish you success in achieving it over the next 30 days!",
    "complete_project_notice": "You have achieved your goal. Congratulations! The stickers you've collected will be retained until you create a new goal.",
    "reset_project_notice": "You did not achieve your goal yesterday, so the goal has been reset to day 1. 😢",
    "confirm_before_got_sticker": "Have you achieved today's goal? If so, claim your sticker!",
    "duplicated_nickname": "This nickname is already in use.",
    "can_not_register_favorite_sticker_more_than_3" : "You cannot register more than 3 favorite stickers.",
    "no_goal_set" : "No goal",
    "today_sticker_already_got": "You have already received today's sticker.",
    "change_nickname_try": "Please enter the new nickname.",
    "change_nickname_completed": "The nickname has been changed.",
    "over_nickname_length": "The nickname cannot exceed 26 bytes (English UpperCase letters are 1.5 bytes and English LowerCase letters and spaces are 1 byte).",
    "under_nickname_length" : "The nickname must be at least 12 bytes (Korean characters are 2 bytes, uppercase English letters are 1.5 bytes, spaces and lowercase English letters are 1 byte).",
    "log_out_complete": "Logout completed.",
    "delete_account_try": "If you delete your account, you can re-register at any time, but your goal settings and collected stickers will be deleted. Are you sure you want to delete your account?",
    "delete_account_complete": "Account deletion completed.",
    "choice_below" : "Please select the following options.",
    "only_nickname" : "Display only the nickname.",
    "both_nickname_and_auth_id" : "Display both the nickname and the logged-in account.",
    "register_hall_of_fame_complete" : "Registration in the Hall of Fame has been completed.",
    "delete_hall_of_fame_complete" : "Deletion has been completed.",
    //"diary_sticker_order_update_try" : "Would you like to save the updated sticker order?",
    "duplicated_hall_of_fame" : "The goal has already been registered in the Hall of Fame.",
    "not_allowed_character" : "A nickname that includes special characters or starts with 'User' is not allowed.",
    "over_project_name_length" : "The project name cannot exceed 26 bytes (English UpperCase letters are 1.5 bytes and English LowerCase letters and spaces are 1 byte).",
    "under_project_name_length" : "The project name must be at least 6 bytes (Korean characters are 2 bytes, uppercase English letters are 1.5 bytes, spaces and lowercase English letters are 1 byte).",
    "can_hit_favorite_to_sticker_after_got_all_sticker" : "You can designate a favorite sticker only after collecting all stickers.",
    "app_title" : "Greaticker",
    "app_description" : "Achieve your goals \nand collect all the stickers!",
  }
};
