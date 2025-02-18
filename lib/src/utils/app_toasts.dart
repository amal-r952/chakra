import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';

class AppToasts {
  static void showSuccessToastTop(BuildContext context, String message) {
    CherryToast.success(
      title: Text(
        'Success',
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
      displayIcon: true,
      description: Text(
        message,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showSuccessToastBottom(BuildContext context, String message) {
    CherryToast.success(
      title: const Text('Success'),
      displayIcon: true,
      description: Text(
        message,
        textAlign: TextAlign.center,
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
    ).show(context);
  }

  // Error Toasts
  static void showErrorToastTop(BuildContext context, String message) {
    CherryToast.error(
      title: const Text('Error'),
      displayIcon: true,
      description: Text(
        message,
        textAlign: TextAlign.center,
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showErrorToastBottom(BuildContext context, String message) {
    CherryToast.error(
      title: const Text('Error'),
      displayIcon: true,
      description: Text(
        message,
        textAlign: TextAlign.center,
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
    ).show(context);
  }

  // Warning Toasts
  static void showWarningToastTop(BuildContext context, String message) {
    CherryToast.warning(
      title: const Text('Warning'),
      displayIcon: true,
      description: Text(
        message,
        textAlign: TextAlign.center,
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showWarningToastBottom(BuildContext context, String message) {
    CherryToast.warning(
      title: const Text('Warning'),
      displayIcon: true,
      description: Text(
        message,
        textAlign: TextAlign.center,
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
    ).show(context);
  }

  // Info Toasts
  static void showInfoToastTop(BuildContext context, String message) {
    CherryToast.info(
      title: const Text('Info'),
      displayIcon: true,
      description: Text(
        message,
        textAlign: TextAlign.center,
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.top,
    ).show(context);
  }

  static void showInfoToastBottom(BuildContext context, String message) {
    CherryToast.info(
      title: const Text('Info'),
      displayIcon: true,
      description: Text(
        message,
        textAlign: TextAlign.center,
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 500),
      autoDismiss: true,
      toastDuration: const Duration(seconds: 2),
      toastPosition: Position.bottom,
    ).show(context);
  }
}
