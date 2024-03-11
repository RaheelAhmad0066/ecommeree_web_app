import 'package:ecommerce/views/invoice_screen/new_bussiness_details.dart';
import 'package:ecommerce/views/invoice_screen/new_items.dart';
import 'package:ecommerce/views/screens/colors_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:ecommerce/providers/user_data_provider.dart';
import 'package:ecommerce/views/screens/crud_detail_screen.dart';
import 'package:ecommerce/views/screens/crud_screen.dart';
import 'package:ecommerce/views/screens/dashboard_screen.dart';
import 'package:ecommerce/views/screens/error_screen.dart';
import 'package:ecommerce/views/screens/general_ui_screen.dart';
import 'views/screens/auth/login_screen.dart';
import 'views/screens/auth/logout_screen.dart';
import 'views/screens/auth/my_profile_screen.dart';
import 'views/screens/auth/register_screen.dart';

class RouteUri {
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String myProfile = '/my-profile';
  static const String logout = '/logout';
  static const String form = '/form';
  static const String generalUi = '/general-ui';
  static const String colors = '/colors';
   
  static const String dialogs = '/dialogs';
  static const String error404 = '/404';
  static const String login = '/login';
  static const String register = '/register';
  static const String crud = '/crud';
  static const String bussinessDetailes = '/bussiness';
  static const String newitems = '/newitems';
  static const String newcustomerDetails = '/newcustomerdetails';
  static const String crudDetail = '/crud-detail';
  static const String iframe = '/iframe';
}

const List<String> unrestrictedRoutes = [
  RouteUri.error404,
  RouteUri.logout,
  RouteUri.login, // Remove this line for actual authentication flow.
  RouteUri.register, // Remove this line for actual authentication flow.
];

const List<String> publicRoutes = [
  // RouteUri.login, // Enable this line for actual authentication flow.
  // RouteUri.register, // Enable this line for actual authentication flow.
];

GoRouter appRouter(UserDataProvider userDataProvider) {
  return GoRouter(
    initialLocation: RouteUri.home,
    errorPageBuilder: (context, state) => NoTransitionPage<void>(
      key: state.pageKey,
      child: const ErrorScreen(),
    ),
    routes: [
      GoRoute(
        path: RouteUri.home,
        redirect: (context, state) => RouteUri.dashboard,
      ),
      GoRoute(
        path: RouteUri.dashboard,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.myProfile,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const MyProfileScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.logout,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const LogoutScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.generalUi,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: GeneralUiScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.colors,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: CreateCustomer(),
        ),
      ),
      GoRoute(
        path: RouteUri.login,
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: RouteUri.register,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const RegisterScreen(),
          );
        },
      ),
      GoRoute(
        path: RouteUri.crud,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: const CrudScreen(),
          );
        },
      ),

      GoRoute(
        path: RouteUri.bussinessDetailes,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child:  NewBusinessScreen(),
          );
        },
      ), GoRoute(
        path: RouteUri.newcustomerDetails,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child:  CreateCustomer(),
          );
        },
      ), GoRoute(
        path: RouteUri.newitems,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child:  New_Items(),
          );
        },
      ),
         GoRoute(
        path: RouteUri.crudDetail,
        pageBuilder: (context, state) {
          return NoTransitionPage<void>(
            key: state.pageKey,
            child: CrudDetailScreen(id: state.queryParameters['id'] ?? ''),
          );
        },
      ),
    ],
    redirect: (context, state) {
      if (unrestrictedRoutes.contains(state.matchedLocation)) {
        return null;
      } else if (publicRoutes.contains(state.matchedLocation)) {
        // Is public route.
        if (userDataProvider.isUserLoggedIn()) {
          // User is logged in, redirect to home page.
          return RouteUri.home;
        }
      } else {
        // Not public route.
        if (!userDataProvider.isUserLoggedIn()) {
          // User is not logged in, redirect to login page.
          return RouteUri.login;
        }
      }
      return null;
    },
  );
}
