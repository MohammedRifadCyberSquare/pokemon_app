import 'package:app/shared/ui/widgets/pokeball.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PokeDexGrid extends StatelessWidget {
  final String gridText;
  final Color  gridColor;
  PokeDexGrid({
    required this.gridText,
    required this.gridColor
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Container(
        height: 20,
        width: 155,
        decoration: BoxDecoration(
          color:gridColor,

          // color: onTap != null
          //     ? color
          //     : AppTheme.getColors(context).drawerDisabled,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned(
                top: -12,
                right: -14,
                child: PokeballWidget(
                  size: 83,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                top: -60,
                left: -50,
                child: PokeballWidget(
                  size: 83,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                     gridText,
                      style: textTheme.bodyText1?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
