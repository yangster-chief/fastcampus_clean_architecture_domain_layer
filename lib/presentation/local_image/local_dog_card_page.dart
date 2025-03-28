import 'package:clean_architecture_layer_exam/presentation/local_image/bloc/local_dog_images_bloc.dart';
import 'package:clean_architecture_layer_exam/presentation/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///
/// clean_architecture_layer_exam
/// File Name: local_dog_card_page
/// Created by sujangmac
///
/// Description:
///
class LocalDogCardPage extends StatefulWidget {
  const LocalDogCardPage({super.key});

  @override
  State<LocalDogCardPage> createState() => _LocalDogCardPageState();
}

class _LocalDogCardPageState extends State<LocalDogCardPage> {
  final CardSwiperController controller = CardSwiperController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<LocalDogImagesBloc>().add(const GetLocalDogImagesEvent());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<LocalDogImagesBloc, LocalDogImagesState>(
        builder: (context, state) {
          if (state is LocalDogImagesLoading) {
            return const LoadingDogCardFrame();
          } else if (state is LocalDogImagesLoaded) {
            final cards = state.images.map(DogImageCard.new).toList();
            return LocalDogCardFrame(
              items: state.images,
              controller: controller,
              onSwipe: _onSwipe,
              cards: cards,
              onClearAll: () {
                context
                    .read<LocalDogImagesBloc>()
                    .add(const ClearDogImagesEvent());
              },
              onDelete: () {
                context
                    .read<LocalDogImagesBloc>()
                    .add(DeleteDogImageEvent(state.images[_currentIndex].id));
                showToastMessage('deleted');
              },
            );
          } else if (state is LocalDogImagesError) {
            return RefreshDogCardFrame(
              text: 'Error : ${state.error}',
              onRefresh: () {
                context
                    .read<LocalDogImagesBloc>()
                    .add(const GetLocalDogImagesEvent());
              },
            );
          } else if (state is LocalDogImagesIsEmpty) {
            return RefreshDogCardFrame(
              text: 'Empty',
              onRefresh: () {
                context
                    .read<LocalDogImagesBloc>()
                    .add(const GetLocalDogImagesEvent());
              },
            );
          } else {
            return RefreshDogCardFrame(
              text: 'Need to Refresh',
              onRefresh: () {
                context
                    .read<LocalDogImagesBloc>()
                    .add(const GetLocalDogImagesEvent());
              },
            );
          }
        },
      );

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    _currentIndex = currentIndex ?? 0;
    return true;
  }
}
