import 'package:flutter/material.dart';
import 'routes.dart';

// Pages - Authentication & Verification
import 'package:firstproduction_pro/pages/main_screens/welcome_screen.dart';
import 'package:firstproduction_pro/pages/auth/signup_screen.dart';
import 'package:firstproduction_pro/pages/auth/set_password_screen.dart';
import 'package:firstproduction_pro/pages/auth/log_in_screen.dart';
import 'package:firstproduction_pro/pages/auth/reset_password_screen.dart';
import 'package:firstproduction_pro/pages/auth/company_verification_screen.dart';
import 'package:firstproduction_pro/pages/auth/university_verification_screen.dart';
import 'package:firstproduction_pro/pages/auth/uni_create_account_screen.dart';
import 'package:firstproduction_pro/pages/auth/create_company_account_screen.dart';
// Pages - Core App & Onboarding
import 'package:firstproduction_pro/pages/auth/Primary_goals.dart';
import 'package:firstproduction_pro/pages/main_screens/home_page_screen.dart';
import 'package:firstproduction_pro/pages/auth/Crafting_space.dart';
import 'package:firstproduction_pro/pages/question/personalization_loading_screen.dart';

// Pages - Assessment Journey
import 'package:firstproduction_pro/pages/question/assesment_page_screen.dart';
import 'package:firstproduction_pro/pages/question/m2_current_energy_and_mood_screen.dart';
import 'package:firstproduction_pro/pages/question/reduce_anxiety_feelings_screen.dart';
import 'package:firstproduction_pro/pages/question/overwhelmed_actions_screen.dart';
import 'package:firstproduction_pro/pages/question/support_level_screen.dart';
import 'package:firstproduction_pro/pages/question/sleep_quality_screen.dart';
import 'package:firstproduction_pro/pages/question/physical_activity_screen.dart';
import 'package:firstproduction_pro/pages/question/stress_sources_screen.dart';
import 'package:firstproduction_pro/pages/question/stress_location_screen.dart';
import 'package:firstproduction_pro/pages/question/stress_challenges_screen.dart';
import 'package:firstproduction_pro/pages/question/learning_preference_screen.dart';
import 'package:firstproduction_pro/pages/question/open_reflection_screen.dart';
import 'package:firstproduction_pro/pages/question/do_you_currently_have_any_mindfulness_routines.dart';
import 'package:firstproduction_pro/pages/question/weekly_commitment.dart';

// Pages - Results & Analysis
import 'package:firstproduction_pro/pages/question/insights_review_screen.dart';
//posh_pages
import 'package:firstproduction_pro/pages/posh_pages/posh_1.dart';
import 'package:firstproduction_pro/pages/posh_pages/complaint_registered_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/complaint_submitted_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/physical_harassment_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/posh_policy_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/verbal_harassment_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/physical_harassment_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/visual_digital_harassment_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/upload_evidence_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/workplace_definition_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/report_complaint_anonymous.dart';
import 'package:firstproduction_pro/pages/posh_pages/compliant_tracking_screen.dart';
import 'package:firstproduction_pro/pages/posh_pages/help_and_support1.dart';
import 'package:firstproduction_pro/pages/posh_pages/help_and_support2.dart';
import 'package:firstproduction_pro/pages/posh_pages/help_and_support3.dart';
import 'package:firstproduction_pro/pages/posh_pages/help_support_screen4.dart';
import 'package:firstproduction_pro/pages/posh_pages/help_and_support5.dart';
import 'package:firstproduction_pro/pages/posh_pages/help_and_support6.dart';
import 'package:firstproduction_pro/pages/new_pages/hr_dashboard_page.dart';
import 'package:firstproduction_pro/pages/new_pages/login_page.dart';
import 'package:firstproduction_pro/pages/new_pages/normal_user_dashboard_page.dart';
import 'package:firstproduction_pro/pages/new_pages/normal_user_dashboard_page.dart';
import 'package:firstproduction_pro/pages/new_pages/normal_user_login_page.dart';
import 'package:firstproduction_pro/pages/new_pages/organisation_user_dashboard_page.dart';
import 'package:firstproduction_pro/pages/new_pages/organisation_user_signup_page.dart';
import 'package:firstproduction_pro/pages/new_pages/report_monitoring_page.dart';
import 'package:firstproduction_pro/pages/new_pages/role_selection_page.dart';
import 'package:firstproduction_pro/pages/question/org_questions/question1.dart';
import 'package:firstproduction_pro/pages/question/org_questions/orgquizstart.dart';
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => const RoleSelectionPage());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.setPassword:
        return MaterialPageRoute(builder: (_) => const SetPasswordScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case Routes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());

      // Verification Flow
      case Routes.companyVerification:
        return MaterialPageRoute(builder: (_) => const CompanyVerification());
      case Routes.universityVerification:
        return MaterialPageRoute(
          builder: (_) => const UniversityVerification(),
        );
      case Routes.uniSignUp:
        return MaterialPageRoute(
          builder: (_) => const UniCreateAccountScreen(),
        );
      case Routes.companySignUp:
        return MaterialPageRoute(
          builder: (_) => const CompanyCreateAccountScreen(),
        );

      // Main Navigation
      case Routes.primary:
        return MaterialPageRoute(builder: (_) => const TopBar());
      case Routes.loading:
        return MaterialPageRoute(builder: (_) => const LoadingPage());
      case Routes.home:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: Duration(milliseconds: 500),
        );

      case Routes.assessment:
        return MaterialPageRoute(builder: (_) => WellbeingAssessmentScreen());

      case Routes.m2mood:
        return MaterialPageRoute(
          builder: (_) => MoodSelectionScreen(questionid_2: 2),
        );
      case Routes.m3primary:
        return MaterialPageRoute(
          builder: (_) => ReduceAnxietyFeelingsScreen(questionid_3: 3),
        );
      case Routes.m4copping:
        return MaterialPageRoute(
          builder: (_) => OverwhelmedActionsScreen(questionid_4: 4),
        );
      case Routes.m5support:
        return MaterialPageRoute(
          builder: (_) => SupportLevelScreen(questionid_5: 5),
        );

      case Routes.m2sleep:
        return MaterialPageRoute(
          builder: (_) =>
              SleepQualityScreen(questionid_6_1: 60, questionid_6_2: 61),
        );

      case Routes.physicalActivity:
        return MaterialPageRoute(
          builder: (_) => const PhysicalActivityScreen(questionid_7: 7),
        );

      case Routes.stress:
        return MaterialPageRoute(
          builder: (_) => StressSourcesScreen(questionid_9: 9),
        );

      case Routes.stresslocation:
        return MaterialPageRoute(
          builder: (_) => StressLocationScreen(questionid_10: 10),
        );

      // Ensure this matches the Step 12 Focus Area we built
      case Routes.stresschallenge:
        return MaterialPageRoute(
          builder: (_) => StressChallengesScreen(questionid_11: 11),
        );

      case Routes.learningPreference:
        return MaterialPageRoute(
          builder: (_) => LearningPreferenceScreen(questionid_12: 12),
        );

      case Routes.m4opensharing:
        return MaterialPageRoute(
          builder: (_) => M4OpenSharingScreen(questionid_14: 14),
        );

      // THE FINAL SEQUENCE - Using a FadeTransition for a smoother "Processing" feel
      case Routes.m4processing:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const M4ProcessingScreen(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 800),
        );

      case Routes.insights:
        return MaterialPageRoute(
          builder: (_) => const M4InsightsScreen(questionid_15: 15),
        );

      case Routes.m2mindfulness:
        return MaterialPageRoute(
          builder: (_) => const MindfulnessRoutineScreen(questionid_8: 8),
        );

      case Routes.m4weekly:
        return MaterialPageRoute(
          builder: (_) => const WeeklyCommitment(questionid_13: 13),
        );

      case Routes.home:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const HomeScreen(),
          transitionsBuilder: (_, animation, __, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 500),
        );

      case Routes.posh1:
        return MaterialPageRoute(builder: (_) => const PoshAwarenessScreen());
      case Routes.poshpolicy:
        return MaterialPageRoute(builder: (_) => const PoshPolicyScreen());
      case Routes.poshpolicy8:
        return MaterialPageRoute(
          builder: (_) => const VerbalHarassmentScreen(),
        );
      case Routes.poshpolicy10:
        return MaterialPageRoute(
          builder: (_) => const VisualDigitalHarassmentScreen(),
        );
      case Routes.poshpolicy11:
        return MaterialPageRoute(
          builder: (_) => const WorkplaceDefinitionScreen(),
        );
      case Routes.poshpolicy12:
        return MaterialPageRoute(builder: (_) => const UploadEvidenceScreen());
      case Routes.poshpolicy9:
        return MaterialPageRoute(
          builder: (_) => const PhysicalHarassmentScreen(),
        );
      case Routes.reportcompliant:
        return MaterialPageRoute(builder: (_) => const ComplaintFormScreen());
      case Routes.compliantsucess:
        return MaterialPageRoute(
          builder: (_) => const ComplaintRegisteredScreen(),
        );

      case Routes.poshcompliant5:
        return MaterialPageRoute(builder: (_) => ComplaintTrackingScreen());

      case Routes.help1:
        return MaterialPageRoute(builder: (_) => const HelpHomeScreen());
      case Routes.help2:
        return MaterialPageRoute(builder: (_) => const ContactOfficerPage());
      case Routes.help3:
        return MaterialPageRoute(builder: (_) => const EmergencyPage());
      case Routes.help4:
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen4());
      case Routes.help5:
        return MaterialPageRoute(builder: (_) => const HelpAndSupport5());
      case Routes.help6:
        return MaterialPageRoute(builder: (_) => const HelpAndSupport6());
      case Routes.login2:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case Routes.normalUserDashboard:
        return MaterialPageRoute(builder: (_) => const NormalUserDashboardPage());
      case Routes.organisationUserDashboard:
        return MaterialPageRoute(
          builder: (_) => const OrganisationUserDashboardPage(),
        );
      case Routes.hrDashboard:
        return MaterialPageRoute(builder: (_) => const HrDashboardPage());
      case Routes.normalUserLogin:
        return MaterialPageRoute(builder: (_) => const NormalUserLoginPage());
      case Routes.organisationUsersignup:
        return MaterialPageRoute(
          builder: (_) => const OrganisationUserSignupPage(),
        );
        case Routes.reportmonitoringpage:
          return MaterialPageRoute(builder: (_) => const ReportMonitoringPage());
        // case Routes.roleSelectionPage:
        //   return MaterialPageRoute(builder: (_) => const RoleSelectionPage());
        case Routes.orgUserQuiz:
          return MaterialPageRoute(builder: (_) => const Question1WorkExperience());
        case Routes.normalUserQuiz:
          return MaterialPageRoute(builder: (_) => WellbeingAssessmentScreen());

        
        default:
          return _errorRoute();
            }
          }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) =>
          const Scaffold(body: Center(child: Text('Route not found'))),
    );
  }
}
 